import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/alert_dialogue.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/add_medicine_screen.dart';
import 'package:kode_rx/Pages/add_new_medicine.dart';
import 'package:kode_rx/Pages/patient_info.dart';
import 'package:kode_rx/Pages/rx_history.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/profile.dart';
import 'package:http/http.dart' as http;

import 'app_colors.dart';
import 'device_helper.dart';

var username = ''.obs;
var userStatus = ''.obs;

class HomeScreen extends StatelessWidget {
  final UserModel? currentUser;
  const HomeScreen({super.key, this.currentUser});

  static HomeScreen get instance => Get.find();

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
              context: Get.overlayContext!,
              builder: (context) => CustomDialog(
                    dialogTitle: 'Exit App',
                    onLeftButtonPressed: () => Navigator.of(context).pop(false),
                    onRightButtonPressed: () => Get.back(result: true),
                    dialogMessage: 'Do you want to exit the app?',
                  )) ??
          false;
    }

    final isTablet = DeviceHelper.getDeviceType() == DeviceType.tablet;
    final controller = Get.put(ProfileController());
    final userRepository = Get.put(UserRepo());

    UserController userController = Get.put(UserController());

    Future<Uint8List> getImageBytes(String imageUrl) async {
      var response = await http.get(Uri.parse(imageUrl));
      userController.signatureStoreInBytes.value = response.bodyBytes;
      return response.bodyBytes;
    }

    // Future<void> loadUser() async {
    //   print(await controller.getUserData());
    // }
    
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
              child: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.customBackground,
                  ),
                  child: Text(
                    'Hello, Dr. ${userController.currentLoggedInUserName.value}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    // onDrawerItemClick(context, 'Profile');
                    //  () => Navigator.of(context).pop();
                    Navigator.pop(context);

                    Get.to(() => Profile());
                    // Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Add Medicines'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.pop(context);
                    userController.isMedicineSelected.value = false;
                    Get.to(() => AddNewMedicine());
                  },
                ),
              ],
            ),
          )),
          body: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFF008095)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.menu,
                                  color: AppColors.customBackground),
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(12, 40, 20, 0),
                            child: Text("KodeRx",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: AppColors.customBackground)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: FutureBuilder(
                          future: controller.getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                UserModel userData = snapshot.data as UserModel;
                                if(userData.accountStatus != 'active') {
                                  userRepository.disableAccount('active');
                                }
                                userStatus.value = userData.status!;
                                // userController.currentLoggedInUserName.value =
                                //     userData.fullname;
                                username.value = userData.fullname;
                                if (userData.signature != '') {
                                  userController.signatureStore.value =
                                      userData.signature;
                                  getImageBytes(userData.signature);
                                }
                                return Row(
                                  children: [
                                    userData.profileImage != ''
                                        ? CircleAvatar(
                                            radius: 55.0,
                                            backgroundImage: NetworkImage(
                                              userData.profileImage,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            radius: 55.0,
                                            backgroundImage: NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/128/8815/8815112.png'),
                                          ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hello, Dr. ${userData.fullname}',
                                          style: TextStyle(
                                            fontSize: isTablet ? 28.0 : 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.customBackground,
                                          ),
                                        ),
                                        Text(
                                          userData.specialist,
                                          style: TextStyle(
                                            fontSize: isTablet ? 28.0 : 14.0,
                                            color: AppColors.customBackground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.customBackground,
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.customBackground,
                                ),
                              );
                            }
                            // return Container();
                          },
                        ),
                      ),
                      const SizedBox(height: 150.0),
                      Container(
                        width: double.infinity, // Full width
                        height: 500.0,
                        child: Image.asset(
                          'assets/images/ic_home_bg.png', // Adjust the BoxFit as per your requirement
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SquareModule(
                    icon: 'assets/images/ic_rx.png',
                    text: 'Make Rx',
                    isTablet: isTablet,
                  ),
                  SquareModule(
                    icon: 'assets/images/ic_rx_history.png',
                    text: 'Rx History',
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

class SquareModule extends StatelessWidget {
  final String icon;
  final String text;
  final bool isTablet;

  const SquareModule({
    super.key,
    required this.icon,
    required this.text,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var snack = Get.snackbar('Subscription Expired', 'Your subcription has expired', colorText: Colors.redAccent);
        if (text == 'Make Rx') {
          if (userStatus.value == '1') {
            Get.to(() => Patient_info());
          } else if (userStatus.value == '0') {
            Get.snackbar('Subscription Expired', '',
                titleText: Text(
                  'Please contact the Administrator',
                  style: TextStyle(fontSize: 24, color: Colors.redAccent),
                ),
                colorText: Colors.redAccent,
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.dangerous,
                  color: Colors.redAccent,
                ));
          }
        } else if (text == 'Rx History') {
          // Handle navigation to Rx History screen
          if (userStatus.value == '1') {
            Get.to(() => RxHistory());
          } else if (userStatus.value == '0') {
            Get.snackbar('Subscription Expired', '',
                titleText: Text(
                  'Please contact the Administrator',
                  style: TextStyle(fontSize: 24, color: Colors.redAccent),
                ),
                colorText: Colors.redAccent,
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.dangerous,
                  color: Colors.redAccent,
                ));
          }
        }
      },
      child: Container(
        width: isTablet ? 250.0 : 150.0,
        height: isTablet ? 250.0 : 150.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF008095), Color(0xFF008095)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(icon),
              width: isTablet ? 100.0 : 40.0,
              height: isTablet ? 100.0 : 40.0,
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: isTablet ? 20.0 : 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
