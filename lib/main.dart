import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Pages/splashscreen.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/patient_home.dart';
import 'package:kode_rx/register.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:kode_rx/test.dart';
import 'app_colors.dart';
import 'home.dart';
import 'otp_screen.dart';
import 'login.dart'; // Import the login screen

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepo()));
  runApp( const MyApp());
  Get.put(Signup());
  // Get.put(OTPScreen());
  Get.put(HomeScreen());
  Get.put(SplashScreen());
  Get.put(LoginScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: '/login',
      // routes: {
      //   '/login': (context) => LoginScreen(),
      //   '/home': (context) => HomeScreen(),
      //   '/selectMedicenesScreen': (context) => MedicationReminderApp(),
      //   '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
      //   '/register': (context) => Signup(),
      //   '/otpPage': (context) => OTPScreen(),
      // },
      home: MedicationListScreen(), // Use the LoginScreen widget here
    );
  }
}
