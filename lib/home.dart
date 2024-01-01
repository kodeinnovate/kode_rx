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
import 'package:kode_rx/Pages/privacy_policy_screen.dart';
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
    final isTablet = MediaQuery.of(context).size.shortestSide > 600;
    final controller = Get.put(ProfileController());
    final userRepository = Get.put(UserRepo());
    UserController userController = Get.put(UserController());

    Future<Uint8List> getImageBytes(String imageUrl) async {
      var response = await http.get(Uri.parse(imageUrl));
      userController.signatureStoreInBytes.value = response.bodyBytes;
      return response.bodyBytes;
    }

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

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Drawer(
            child: ListView(
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
                    Navigator.pop(context);
                    Get.to(() => Profile());
                  },
                ),
                ListTile(
                  title: const Text('Add Medicines'),
                  onTap: () {
                    Navigator.pop(context);
                    userController.isMedicineSelected.value = false;
                    Get.to(() => AddNewMedicine());
                  },
                ),
                ListTile(
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => PrivacyPolicy());
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: isTablet
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.4,
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
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                20, isTablet ? 40 : 20, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.menu,
                                  color: AppColors.customBackground),
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                12, isTablet ? 40 : 20, 20, 0),
                            child: Text("KodeRx",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 26 : 18,
                                    color: AppColors.customBackground)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            20, isTablet ? 20 : 10, 0, 0),
                        child: FutureBuilder(
                          future: controller.getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                UserModel userData =
                                snapshot.data as UserModel;
                                if (userData.accountStatus != 'active') {
                                  userRepository.disableAccount('active');
                                }
                                userStatus.value = userData.status!;
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
                                      radius: isTablet ? 44.0 : 22.0,
                                      backgroundImage: NetworkImage(
                                        userData.profileImage,
                                      ),
                                    )
                                        :  CircleAvatar(
                                      radius: isTablet ? 44.0 : 22.0,
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
                                            fontSize: isTablet ? 22.0 : 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.customBackground,
                                          ),
                                        ),
                                        Text(
                                          userData.specialist,
                                          style: TextStyle(
                                            fontSize: isTablet ? 22.0 : 16.0,
                                            color: AppColors.customBackground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.customBackground,
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.customBackground,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: isTablet ? 40.0 : 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: isTablet ? 400.0 : 200.0,
                        child: Image.asset(
                          'assets/images/ic_home_bg.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isTablet ? 40.0 : 20.0),
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
          ],
        ),
      ),
    );
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
        width: isTablet ? 200.0 : 100.0,
        height: isTablet ? 200.0 : 100.0,
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
