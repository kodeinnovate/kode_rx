import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const CustomTextfield(
      {super.key, required this.controller, required this.hintText, required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.customBackground),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])
            ),
      ),
    );
  }
}