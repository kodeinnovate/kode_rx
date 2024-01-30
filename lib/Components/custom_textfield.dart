import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final controller;
  final bool? readOnly;
  final int? maxLines;
  final TextInputType keyboardType;
  final String hintText;
  final bool obsecureText;

  const CustomTextfield(
      {super.key,  this.controller, required this.hintText, required this.obsecureText, required this.keyboardType, this.maxLines, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obsecureText,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
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
