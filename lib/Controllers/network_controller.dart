import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // _checkConnection();
    legacyCheck();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Get.snackbar('Offline', 'Please check your connection',
      //     duration: const Duration(days: 1), snackPosition: SnackPosition.BOTTOM);
          legacyCheck();
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  final RxBool connection = false.obs;
  Future<void> legacyCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        connection.value = true;
      }
    } on SocketException catch (_) {
      connection.value = false;
      print('not connected');
    }
    if (connection.isFalse) {
      Get.snackbar('Not Connected', 'Something went wrong',
          duration: Duration(days: 1), );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  Future<void> _checkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        Get.snackbar(
          'No Internet Connect',
          'Please check your connection',
          duration: const Duration(days: 1),
        );
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
    } catch (e) {
      print('Error checking connection: $e');
    }
  }
}
