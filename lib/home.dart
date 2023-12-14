import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Pages/patient_info.dart';
import 'package:kode_rx/database/database_fetch.dart';

import 'app_colors.dart';
import 'device_helper.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen get instance => Get.find();

  @override
  Widget build(BuildContext context) {
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

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: DeviceHelper.deviceAppBar(
          title: 'Doctor Prescription App',
          isTablet: isTablet,
        ),
        drawer: isTablet
            ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    FutureBuilder(
                      future: controller.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          return DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Text(
                              'Hello, Dr ${userData.fullname}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          );
                        }
                        return DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            'Hello, Dr',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Profile'),
                      onTap: () {
                        // Handle navigation to profile
                      },
                    ),
                    ListTile(
                      title: Text('Settings'),
                      onTap: () {
                        // Handle navigation to settings
                      },
                    ),
                  ],
                ),
              )
            : null,
        body: Center(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 120.0,
                        backgroundImage: userData.profileImage != ''
                            ? NetworkImage(userData.profileImage)
                            : NetworkImage(
                                'https://cdn-icons-png.flaticon.com/128/8815/8815112.png'),
                      ),
                      // userData.profileImage != null
                      //     ? CircleAvatar(
                      //   radius: 120.0,
                      //   backgroundImage: NetworkImage(
                      //     userData.profileImage,
                      //   ),
                      // )
                      //     : const CircleAvatar(
                      //   radius: 120.0,
                      //   backgroundImage: NetworkImage(
                      //       'https://cdn-icons-png.flaticon.com/128/8815/8815112.png'),
                      // ),
                      SizedBox(height: 20.0),
                      Text(
                        'Dr. ${userData.fullname}',
                        style: TextStyle(
                          fontSize: isTablet ? 36.0 : 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData.specialist,
                        style: TextStyle(
                          fontSize: isTablet ? 24.0 : 18.0,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareModule(
                            icon: 'assets/images/ic_rx.png',
                            text: 'Make Rx',
                            isTablet: isTablet,
                          ),
                          SizedBox(width: 20.0),
                          SquareModule(
                            icon: 'assets/images/ic_rx_history.png',
                            text: 'Rx History',
                            isTablet: isTablet,
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
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
