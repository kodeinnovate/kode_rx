import 'package:flutter/material.dart';
import 'package:kode_rx/create_appointment.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/patient_home.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:kode_rx/test.dart';
import 'app_colors.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen

void main() {
  runApp(CreateAppointment());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/patientHome',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => MediceneListScreen(),
        '/patientAppointmentScreen': (context) => PatientAppointmentsScreen(),
        '/patientHome' :(context) => PatientHome(),
        '/createAppointment': (context) => CreateAppointment(),
      },
      home: LoginScreen(), // Use the LoginScreen widget here
    );
  }
}
