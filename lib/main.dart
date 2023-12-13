import 'package:flutter/material.dart';
import 'package:kode_rx/demo.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/patient_home.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:kode_rx/splash_screen.dart';
import 'package:kode_rx/test.dart';
import 'app_colors.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen

void main() {
  runApp(MyApp()); //MaterialApp(home: Demo())
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash' : (context) => Splashscreen(), 
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => MedicationReminderApp(),
        '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
      },
      home:Splashscreen(), // Use the LoginScreen widget here
    );
  }
}
