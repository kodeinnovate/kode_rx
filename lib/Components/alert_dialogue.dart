import 'package:flutter/material.dart';
import 'package:kode_rx/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;
  final String? leftButtonText;
  final String? rightButtonText;
  final String dialogTitle;
  final String? dialogMessage;

  const CustomDialog({super.key,  this.onLeftButtonPressed, this.onRightButtonPressed, this.leftButtonText, this.rightButtonText, required this.dialogTitle, this.dialogMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Text(
        dialogTitle,
      ),
      content: Text(dialogMessage ?? ''),
      actions: [
        TextButton(
          onPressed: onLeftButtonPressed,
          child: Text(leftButtonText ?? 'No', style: const TextStyle(color: AppColors.customBackground),),
        ),
        
        TextButton(
          style: TextButton.styleFrom(backgroundColor: AppColors.customBackground),
          onPressed: onRightButtonPressed,
          child: Text(rightButtonText ?? 'Yes', style: const TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}