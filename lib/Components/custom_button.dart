import 'package:flutter/material.dart';
import './../app_colors.dart';

class CustomButtom extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  CustomButtom({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: AppColors.customBackground,
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
