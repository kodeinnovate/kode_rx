import 'package:flutter/material.dart';
import 'dart:async';


class ZoomOutSplashScreen extends StatefulWidget {
  @override
  _ZoomOutSplashScreenState createState() => _ZoomOutSplashScreenState();
}

class _ZoomOutSplashScreenState extends State<ZoomOutSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(_controller);

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      // Navigate to the next screen after 3 seconds
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 200, // Adjust the width of your image
                height: 200, // Adjust the height of your image
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ic_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
