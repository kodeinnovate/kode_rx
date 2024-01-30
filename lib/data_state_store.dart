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
  final RxString doctorRegisterationNo = RxString('');

  final Rx<Uint8List?> profileImage = Rx<Uint8List?>(null);
  final RxString patientName = RxString('');
  final RxString patientAge = RxString('');
  final RxString patientPhoneNo = RxString('');
  final RxString patientGender = RxString('');
  final RxString patientPastHistory = RxString('');
  final RxString userId = RxString('');
  final RxString formatedDate = RxString('');
  // Images //
  final RxString userProfileUpdateUrl = RxString('');
  final RxString userSignitureUpdateUrl = RxString('');
  final RxString signatureStore = RxString('');
  // // /// ////////////////////////////////////////
  // From the database
  final Rx<Uint8List?> signatureStoreInBytes = Rx<Uint8List?>(null);
  final RxString currentLoggedInUserName = RxString('');
  // Storing Medicine Mg Array
  final RxList<String> mgList = <String>[].obs; // Reactive
  //Devices SignatureID
  final RxString signatureId = RxString('');
  //Screen Swap
  final RxBool isMedicineSelected = RxBool(false);
  //AdditionalInfo Screen Data
  // final RxString pastmedicalHistoryDetails = RxString('');
  final RxString diagnosisDetails = RxString('');
  final RxString treatmentDetails = RxString('');

  // Additional Assessment Temperoray data, Arrays for findings, investigation and diagnosis temp data //
  final RxList<String> findings = <String>[].obs;
  final RxList<String> investigation = <String>[].obs;
  final RxList<String> diagnosis = <String>[].obs;
  final RxList<String> chiefComplaints = <String>[].obs;

  // Additional Assessment data from database
  final RxList<String> dbFindingsList = <String>[].obs;
  final RxList<String> dbInvestigationList = <String>[].obs;
  final RxList<String> dbDiagnosisList = <String>[].obs;
  final RxList<String> dbChiefComplaintsList = <String>[].obs;
}

final RxString loginPhoneNumber = RxString('');
