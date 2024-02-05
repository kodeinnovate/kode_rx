import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/patient_info.dart';
import 'package:kode_rx/Pages/splashscreen.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/register.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DependencyInjection.init();
  // try {
  //   final result = await InternetAddress.lookup('google.com');
  //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //     print('connected');
  //   }
  // } on SocketException catch (_) {
  //   print('not connected');
  //   Get.snackbar('Not Connected', 'Something');
  // }
  try {
    //
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    Get.put(AuthenticationRepo());
    await FirebaseAppCheck.instance
        .activate(androidProvider: AndroidProvider.playIntegrity);
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
  Get.put(Signup());
  Get.put(HomeScreen());
  Get.put(SplashScreen());
  Get.put(LoginScreen());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.customBackground),
        primaryColor: AppColors.customBackground,
        backgroundColor: Colors.white,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',

      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => MedicationReminderApp(),
        '/Patient_info': (context) => Patient_info(),
        '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
        '/register': (context) => Signup(),
        // '/otpPage': (context) => OTPScreen(),
      }, // Use the LoginScreen widget here
      home: CircularProgressIndicator(),
    );
  }
}
