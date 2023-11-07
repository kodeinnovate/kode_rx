import 'package:flutter/material.dart';
import 'app_colors.dart';
enum DeviceType { phone, tablet }


class DeviceHelper {
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  // static Colors onClick() {
  //   return 
  // }

  static AppBar deviceAppBar() {
    final deviceType = getDeviceType();

    if (deviceType == DeviceType.tablet) {
      return AppBar(
        title: const Text('Appointment', style: TextStyle(fontSize: 40.0)),
        toolbarHeight: 120,
        backgroundColor: AppColors.customBackground,
      );
    } else if (deviceType == DeviceType.phone) {
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
