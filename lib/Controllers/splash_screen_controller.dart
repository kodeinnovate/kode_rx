
import 'package:get/get.dart';
import 'package:kode_rx/home.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  // RxBool navTo = false.obs;

  Future navigateTo() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.to(HomeScreen());
  }
}