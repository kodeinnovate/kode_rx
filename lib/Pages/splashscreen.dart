import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.navigateTo();
    return Scaffold(
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
