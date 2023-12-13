import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/database/patient_data.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

// Firebase database Initialization
  final _db = FirebaseFirestore.instance;


  //Patient data to be saved in Doctor's profile
   addPatientDetails(String userId, PatientModel patient) async {
    // Create a reference to the user's document
    DocumentReference userRef = _db.collection("Users").doc(userId);

    // Add patient details to a subcollection named 'Patients'
    await userRef
        .collection("Patients")
        .add(patient.toJson())
        .whenComplete(() => Get.snackbar(
              'Success',
              'Patient details have been added.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            ))
        .catchError((error, stackTrace) {
          Get.snackbar(
            'Error',
            'Something went wrong. Try again',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red,
          );
        });
  }


// User Registeration
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
    });
  }

  // Future<String> createUser(UserModel user) async {
  // DocumentReference docRef = await _db.collection("Users").add(user.toJson());

  // // Retrieve the generated document ID as the userId
  // String userId = docRef.id;

  // await Get.snackbar(
  //   'Success',
  //   'Your account has been created.',
  //   snackPosition: SnackPosition.BOTTOM,
  //   backgroundColor: Colors.green.withOpacity(0.1),
  //   colorText: Colors.green,
  // ).catchError((error, stackTrace) {
  //   Get.snackbar(
  //     'Error',
  //     'Something went wrong. Try again',
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.redAccent.withOpacity(0.1),
  //     colorText: Colors.red,
  //   );
  // });

  // Return the generated userId
//   return userId;
// }


// Adding new Medicine into the database
  addMedicine(MedicineModel medicine) async {
    await _db
        .collection("Medicines")
        .add(medicine.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'Medicine has successfully added into the database.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong. Try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  Future<List<MedicineModel>> getMedicineList() async {
    final snapshot = await _db.collection('Medicines').get();
    final medicineData =
        snapshot.docs.map((e) => MedicineModel.fromSnapshot(e)).toList();
    return medicineData;
  }

// For Login Authentication and to check if the user Exists in the db
  Future<UserModel?> getUserDetails(String phoneNo) async {
    final snapshot =
        await _db.collection('Users').where('Phone', isEqualTo: phoneNo).get();
    if (snapshot.docs.isNotEmpty) {
      final getUserData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
      return getUserData;
    } else {
      return null;
    }
  }

  Future<UserModel?> getUserProfile(String phoneNo) async {
    final snapshot =
        await _db.collection('Users').where('Phone', isEqualTo: phoneNo).get();
    if (snapshot.docs.isNotEmpty) {
      final getUserData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return getUserData;
    } else {
      return null;
    }
  }
}
