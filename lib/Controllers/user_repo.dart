import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/database/doctor_medicine_data.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/select_medicenes.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();
  UserController userController = Get.put(UserController());

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

  ///Doctor Specific medicines Data store
  final RxBool addMedicineLoader = false.obs;
  addMedicineForUser(String userId, UserMedicineModel medicine) async {
    // Create a reference to the user's document
    try {
      addMedicineLoader.value = true;
         DocumentReference userRef = _db.collection("Users").doc(userId);
    await userRef
        .collection("Medicines")
        .add(medicine.toJson())
        .whenComplete(() => Get.snackbar(
              'Medicine Successfully Added',
              'Medicine details have been added for the user.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.green,
              icon: const Icon(Icons.check)
            ))
        .catchError((error, stackTrace) {
      Get.snackbar(
        'Error',
        'Something went wrong. Try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
      );
    });
    } catch (e) {
      print(e);
      Get.snackbar('Error', "Something went wrong");
    } finally {
      addMedicineLoader.value = false;
    }
 

    // Add medicine details to a subcollection named 'Medicines'
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

//Test List Don't use
  Future<List<MedicineModel>> getMedicineList() async {
    final snapshot = await _db.collection('Medicines').get();
    final medicineData =
        snapshot.docs.map((e) => MedicineModel.fromSnapshot(e)).toList();
    return medicineData;
  }

//Doctor Specific medicine List

final RxBool medicineLoading = false.obs; //For Loader

  Future<List<UserMedicineModel>> getUserMedicines(String userId) async {
    try {
    medicineLoading.value = true;
    final snapshot =
        await _db.collection('Users').doc(userId).collection('Medicines').get();
    final medicineData =
        snapshot.docs.map((e) => UserMedicineModel.fromSnapshot(e)).toList();
    return medicineData;
    } catch (e) {
      print('Something went wrong $e');
      Get.snackbar('Something Went Wrong', 'Error: $e');
      throw Exception("Failed to fetch medicines");
    } finally {
      medicineLoading.value = false;
    }
  }

Future<void> refreshMedicines({String searchQuery = ''}) async {
    try {
      medicineLoading.value = true;
      final userId = userController.userId.value;
      final snapshot =
          await _db.collection('Users').doc(userId).collection('Medicines').get();
      final medicineData =
          snapshot.docs.map((e) => UserMedicineModel.fromSnapshot(e)).toList();

      // Use assignAll to update the RxList
      GlobalMedicineList.medicines.assignAll(
        medicineData.map((medicineModel) => Medicine.fromMedicineModel(medicineModel)).toList(),
      );
     GlobalMedicineList.medicines.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));


      update(); // Manually trigger a rebuild
      // displayedMedicines = GlobalMedicineList.medicines
      //     .where((medicine) {
      //       if (medicine.status == '0') {
      //         return false;
      //       } else if (medicine.status == '1') {
      //         return true;
      //       } else {
      //         return true;
      //       }
      //     })
      //     .toList();
          // .where((medicine) =>
          //     medicine.name.toLowerCase().contains(searchQuery.toLowerCase()))
          // .toList();

    } catch (e) {
      Get.snackbar('Something Went Wrong', 'Error: $e');
    } finally {
      medicineLoading.value = false;
    }
  }



  //Doctor Specific patient List
  Future<List<PatientModel>> getUserPatients(String userId) async {
    final snapshot =
        await _db.collection('Users').doc(userId).collection('Patients').get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
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

// Gets The current user details
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

final RxBool isLoading = false.obs;
// For updating the data of the current user
  Future<void> updateUserRecords(UserModel user) async {
    try {
      isLoading.value = true;
      final userId = userController.userId.value;
      await _db.collection('Users').doc(userId).update(user.toJson());
      Get.snackbar('Success', 'Profile updated Successfully', backgroundColor: Colors.white, colorText: Colors.black );
      print('User records updated successfully!');
    } catch (e) {
      print('Error updating user records: $e');
      Get.snackbar('Something went wrong', 'Please try again later');
    } finally {
      isLoading.value = false; // Set loading to false when the update completes (success or failure)
    }
  }

// Account delection or Disabling
Future<void> disableAccount(String status) async {
   final userId = userController.userId.value;
  try {
  await _db.collection('Users').doc(userId).update({
        'AccountStatus': status, // Update to disabled
      });
      // if(status == 'deactivate') {
      //   Get.snackbar('Account has been Suspended', 'Your account has been deactivated, you can reenable it by logging in');
      // }     
      // if (status == 'delete') {
      //   Get.snackbar('Account has been been set to DELETE', 'Your account has been deactivated, you it your will be permanently deleted in 10 days');
      // } 
      // if (status == 'active') {
      //   Get.snackbar('Account Reactivated', 'Your Account has been Reinstated');
      // }
  } catch (e) {
          print('Error updating account status: $e');
          Get.snackbar('Error updating account status:', '$e');

  } finally {
      if(status == 'deactivate') {
        Get.snackbar('Account deactivated', 'Your Account Has been deactivated');
      }
      if(status == 'delete') {
        Get.snackbar('Your Account Has been set to delete in 10 days', 'You can login to reactivate');
      }
      if (status == 'active') {
        Get.snackbar('Account Reactivated', 'Your Account has been Reinstated');
      }

  }
}
}

