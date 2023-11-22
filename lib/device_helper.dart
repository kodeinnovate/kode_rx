import 'package:flutter/material.dart';
import 'app_colors.dart';

enum DeviceType { phone, tablet }
// enum AuthOperation { signUp, signIn }

class DeviceHelper {
  final String title;
  DeviceHelper({required this.title});
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  static AppBar deviceAppBar({String? title}) {
    final deviceType = getDeviceType();

    if (deviceType == DeviceType.tablet) {
      return AppBar(
        leading: null,
        title: Text((title ?? 'KodeNeo'),
            style: const TextStyle(fontSize: 40.0, color: Colors.white)),
        toolbarHeight: 120,
        backgroundColor: AppColors.customBackground,
      );
    } else if (deviceType == DeviceType.phone) {
      return AppBar(
        leading: null,
        centerTitle: true,
        toolbarHeight: 65,
        title: Text(
          (title ?? 'KodeNeo'),
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: AppColors.customBackground,
      );
    } else {
      return AppBar(
        leading: null,
        title: Text(
          (title ?? 'KodeNeo'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.customBackground,
      );
    }
  }
}
