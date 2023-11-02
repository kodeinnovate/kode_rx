import 'package:flutter/material.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'app_colors.dart';
import 'home.dart';
import 'login.dart'; // Import the login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/selectMedicenesScreen': (context) => SelectMedicineScreen(),
      },
      home: LoginScreen(), // Use the LoginScreen widget here
    );
  }
}
