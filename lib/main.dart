import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Pages/splashscreen.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/register.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthenticationRepo());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
  Get.put(Signup());
  Get.put(HomeScreen());
  Get.put(SplashScreen());
  Get.put(LoginScreen());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: AppColors.customBackground),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => MedicationReminderApp(),
        '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
        '/register': (context) => Signup(),
        // '/otpPage': (context) => OTPScreen(),
      }, // Use the LoginScreen widget here
      home: LoginScreen(),
    );
  }
}
