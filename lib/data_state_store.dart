import 'dart:typed_data';

import 'package:get/get.dart';

class UserController extends GetxController {
  final RxString verificationID = RxString('');
  final RxString userName = RxString('');
  final RxString userEmail = RxString('');
  final RxString userPhoneNumber = RxString('');
  final RxString doctorsNote = RxString('');
  final RxString userProfileImageUrl = RxString('');
  final RxString userSpecialty = RxString('');
  final Rx<Uint8List?> profileImage = Rx<Uint8List?>(null);
  final RxString patientName = RxString('');
  final RxString patientAge= RxString('');
  final RxString patientPhoneNo = RxString('');
  final RxString patientGender = RxString('');
  final RxString patientPastHistory = RxString('');
  final RxString userId = RxString('');
  final RxString formatedDate = RxString('');
  final RxString userProfileUpdateUrl = RxString('');
  final RxString userSignitureUpdateUrl = RxString('');
  final RxString signatureStore = RxString('');
  // From the database
   final Rx<Uint8List?> signatureStoreInBytes = Rx<Uint8List?>(null);
  final RxString currentLoggedInUserName = RxString('');
}

final RxString loginPhoneNumber = RxString('');
