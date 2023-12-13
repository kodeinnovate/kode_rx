import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Pages/patient_info.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/patient_appointments.dart';

import 'app_colors.dart';
import 'device_helper.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen get instance => Get.find();

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: Get.overlayContext!,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    final isTablet = DeviceHelper.getDeviceType() == DeviceType.tablet;
  final controller = Get.put(ProfileController());
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          appBar: DeviceHelper.deviceAppBar(title: 'Doctor Prescription App'),
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
                            backgroundImage:
                                NetworkImage(userData.profileImage),
                            // backgroundImage: AssetImage('assets/doctor_profile.jpg'), // Replace with the actual image path
                            radius: isTablet ? 120.0 : 80.0,
                          ),
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
                            children: <Widget>[
                              SquareModule(
                                icon: Icons.calendar_today,
                                text: 'Appointments',
                                isTablet: isTablet,
                              ),
                              SizedBox(
                                  width: isTablet
                                      ? 40.0
                                      : 20.0), // Add space between modules
                              SquareModule(
                                icon: Icons.history,
                                text: 'Appointment History',
                                isTablet: isTablet,
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error here${snapshot.error.toString()}'),);
                    } else {
                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            // backgroundImage:
                                // NetworkImage(userData.profileImage),
                            backgroundImage: AssetImage('assets/doctor_profile.jpg'), // Replace with the actual image path
                            radius: isTablet ? 120.0 : 80.0,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Dr. ',
                            style: TextStyle(
                              fontSize: isTablet ? 36.0 : 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Chest Physician',
                            style: TextStyle(
                              fontSize: isTablet ? 24.0 : 18.0,
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SquareModule(
                                icon: Icons.calendar_today,
                                text: 'Appointments',
                                isTablet: isTablet,
                              ),
                              SizedBox(
                                  width: isTablet
                                      ? 40.0
                                      : 20.0), // Add space between modules
                              SquareModule(
                                icon: Icons.history,
                                text: 'Appointment History',
                                isTablet: isTablet,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),);
  }
}

class SquareModule extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isTablet;

  SquareModule(
      {required this.icon, required this.text, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle module tap
        if (text == 'Appointments') {
          // Navigator.of(context).pushReplacementNamed('/patientAppointmentScreen');
          Get.to(() => Patient_info());
        } else if (text == 'Appointment History') {
          // Navigate to Appointment History screen
          // Add your navigation code here
        }
      },
      child: Container(
        width: isTablet ? 200.0 : 150.0,
        height: isTablet ? 200.0 : 150.0,
        decoration: BoxDecoration(
          color: AppColors.customBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: isTablet ? 60.0 : 40.0,
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Center(
              // Center the text both vertically and horizontally
              child: Text(
                text,
                style: TextStyle(
                  fontSize: isTablet ? 24.0 : 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
          ],
        ),
      ),
    );
  }
}
