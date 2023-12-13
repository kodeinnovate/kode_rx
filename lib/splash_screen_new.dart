import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kode_rx/login.dart';
import 'app_colors.dart';

class SplashScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
splash:Column(
  children: [
    Image.asset('assets/images/ic_logo.png', width: MediaQuery.of(context).size.width*0.6,)
  ],
) ,nextScreen:LoginScreen() ,
splashIconSize: 250,
duration: 4000,
splashTransition: SplashTransition.scaleTransition,
backgroundColor: Color.fromRGBO(0, 128, 149, 1),
    );
  }
}
