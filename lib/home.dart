import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
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

class HomeScreen extends StatelessWidget {
  static HomeScreen get instance => Get.find();
  

  @override
  Widget build(BuildContext context) {
    print('hit');
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: Get.overlayContext!,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit the app?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    final isTablet = DeviceHelper.getDeviceType() == DeviceType.tablet;
    final controller = Get.put(ProfileController());
    UserController userController = Get.put(UserController());

     Future<Uint8List> getImageBytes(String imageUrl) async {
  var response = await http.get(Uri.parse(imageUrl));
  userController.signatureStoreInBytes.value = response.bodyBytes;
  return response.bodyBytes;
}

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child:
          Drawer(
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
              child: Text('Hello, Dr. ${userController.currentLoggedInUserName.value}', style: TextStyle(color: Colors.white, fontSize: 24),),
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
                Get.to(() => AddNewMedicine());
              },
            ),
    
          ],
        ),
      )),
        body: Column( children:[

          Container(
          height:  MediaQuery.of(context).size.height * 0.7,
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
              Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child:IconButton(
                    icon: Icon(Icons.menu,color:AppColors.customBackground),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0), // Updated padding
                    child: FutureBuilder(
                      future: controller.getUserData(),
                      builder: (context, snapshot) {
                        print('working');
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel userData = snapshot.data as UserModel;
                            userController.signatureStore.value = userData.signature;
                            userController.currentLoggedInUserName.value = userData.fullname;
                            getImageBytes(userData.signature);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            return const Center(child: CircularProgressIndicator( color: AppColors.customBackground,),);
                          }
                        } else {
                          return const Center(child: CircularProgressIndicator(color: AppColors.customBackground),);
                        }
                        // return Container();
                      },
                    ),
                  ),
                  Padding(
                  padding: EdgeInsets.fromLTRB(28, 28, 0, 0),
                  child: Text("KodeRx",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32)),
                  ),
                  SizedBox(height: 150.0),
              Container(
                width: double.infinity, // Full width
                height: 500.0,
                child: Image.asset(
                  'assets/images/ic_home_bg.png',// Adjust the BoxFit as per your requirement
                ),
              ),

                ],

              ),

            ),
          ),

        ),
    SizedBox(height: 50,),
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
]
      ),
    ));
  }
}


class SquareModule extends StatelessWidget {
  final String icon;
  final String text;
  final bool isTablet;

  SquareModule({
    required this.icon,
    required this.text,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'Make Rx') {
          Get.to(() => Patient_info());
        } else if (text == 'Rx History') {
          // Handle navigation to Rx History screen
          Get.to(() => RxHistory());
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
