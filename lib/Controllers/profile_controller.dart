import 'package:get/get.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Controllers/user_repo.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepo());
  final _userRepo = Get.put(UserRepo());
  var userData;

  getUserData() async {
    final phone = _authRepo.firebaseUser.value?.phoneNumber;
    if (phone != null) {
      return await _userRepo.getUserDetails(phone);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
