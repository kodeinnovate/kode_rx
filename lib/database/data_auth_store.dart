import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/database/database_fetch.dart';

class DataStore extends GetxController {
  static DataStore get instance => Get.find();

  final userRepository = Get.put(UserRepo());

  Future<void> dataStore(UserModel user) async {
    print('Working dataStore');
    await userRepository.createUser(user);
    // AuthenticationRepo.instance.phoneAuthentication(phoneNumberController.text.toString().trim());
  }
}
