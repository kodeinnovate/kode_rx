import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final TextInputType keyboardType;
  

  const CustomTextfield(
      {super.key, required this.controller, required this.hintText, required this.keyboardType, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
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
