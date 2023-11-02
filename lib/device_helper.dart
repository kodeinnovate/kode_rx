import 'package:flutter/material.dart';
import 'app_colors.dart';
enum DeviceType { Phone, Tablet }

class DeviceHelper {
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.Phone : DeviceType.Tablet;
  }

  static AppBar deviceAppBar() {
    final deviceType = getDeviceType();

    if (deviceType == DeviceType.Tablet) {
      return AppBar(
        title: const Text('Appointment', style: TextStyle(fontSize: 40.0)),
        toolbarHeight: 120,
        backgroundColor: AppColors.customBackground,
      );
    } else if (deviceType == DeviceType.Phone) {
      return AppBar(
        title: const Text('Appointment'),
        backgroundColor: AppColors.customBackground,
      );
    } else {
      return AppBar(
        title: const Text('Appointment'),
        backgroundColor: AppColors.customBackground,
      );
    }
  }
}
