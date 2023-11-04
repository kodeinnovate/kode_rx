import 'app_colors.dart';
import 'package:flutter/material.dart';

class DoctorCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 100,
          color: AppColors.customBackground,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Hello World',
              style: TextStyle(fontSize: 24, color: Colors.amber),
            ),
          ),
        ),
      ),
    );
  }
}
