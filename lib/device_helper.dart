import 'package:flutter/material.dart';

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
      );
    } else if (deviceType == DeviceType.Phone) {
      return AppBar(
        title: const Text('Appointment'),
      );
    } else {
      return AppBar(
        title: const Text('Appointment'),
      );
    }
  }
}
