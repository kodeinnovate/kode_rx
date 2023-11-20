import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/database/database_fetch.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong. Try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<UserModel?> getUserDetails(String phoneNo) async {
    print('Running');
    final snapshot =
        await _db.collection('Users').where('Phone', isEqualTo: phoneNo).get();
    if (snapshot.docs.isNotEmpty) {
      final getUserData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
      return getUserData;
    } else {
      print('found nothing');
      return null;
    }
  }
}
