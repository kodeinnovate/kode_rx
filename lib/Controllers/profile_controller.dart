import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/database/database_fetch.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

final username = TextEditingController();
final email = TextEditingController();
final phone = TextEditingController();
final speciality = TextEditingController();
final profileImage = TextEditingController();
final signatureImage = TextEditingController();


//Repo's
  final _authRepo = Get.put(AuthenticationRepo());
  final _userRepo = Get.put(UserRepo());

  getUserData() async {
    // print('hello');
    // Check if firebaseUser is not null before using it
    if (_authRepo.firebaseUser.value != null) {
      final phone = _authRepo.firebaseUser.value!.phoneNumber;
      if (phone != null) {
        return await _userRepo.getUserProfile(phone);
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } else {
      print('something went wrong in getUserData function, this also triggers when the user logs out from the profile page');
      // Handle the case where firebaseUser is not yet initialize
      // Get.snackbar('Error', 'Firebase user not initialized');
    }
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecords(user);
  }
}

