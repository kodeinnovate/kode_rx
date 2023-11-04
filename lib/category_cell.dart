import 'app_colors.dart';
import 'package:flutter/material.dart';

class CatageroieCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 130.0,
        child: const Card(
            color: AppColors.backgroundColor,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomCenter, child: Text('data')))),
      ),
    );
  }
}
