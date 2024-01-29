import 'package:flutter/material.dart';
import './../app_colors.dart';

class CustomButtom extends StatelessWidget {
  final String buttonText;
  final double? margin;
  final Function()? onTap;
  const CustomButtom({super.key, required this.buttonText, required this.onTap, this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: margin ?? 25.0),
        decoration: BoxDecoration(
            color: AppColors.customBackground,
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
