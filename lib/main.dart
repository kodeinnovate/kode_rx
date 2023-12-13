import 'package:flutter/material.dart';
import 'package:kode_rx/demo.dart';
import 'package:kode_rx/forgot_pass.dart';
import 'package:kode_rx/list.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/patient_home.dart';
import 'package:kode_rx/patient_info.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:kode_rx/splash_screen_new.dart';
import 'package:kode_rx/test.dart';
import 'app_colors.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen

void main() {
  runApp(MaterialApp(home: Patient_info(),)); //MaterialApp(home: Demo())
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/splash' : (context) => SplashScreenNew(), 
        '/list' : (context) => List(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => MedicationReminderApp(),
        '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
        '/info' :(context) => Patient_info(),
        
      },
      home:SplashScreenNew(), // Use the LoginScreen widget here
    );
  }
}
