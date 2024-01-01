import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNo;
  final String profileImage;
  final String specialist;
  final String signature;
  final String? status;
  final String? accountStatus;
  final String? doctorRegisterationNo;

  const UserModel(
      {this.id,
      required this.fullname,
      required this.email,
      required this.phoneNo,
      required this.profileImage,
      required this.signature, required this.specialist, this.status, this.accountStatus, this.doctorRegisterationNo});

  toJson() {
    return {
      'Fullname': fullname,
      'Email': email,
      'Phone': phoneNo,
      'ProfileImage': profileImage,
      'Specialist': specialist,
      'Signature': signature,
      'Status': status,
      'AccountStatus': accountStatus,
      'DoctorRegisterationNo': doctorRegisterationNo
    };
  }

// ---------  Data fetch --------- //
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullname: data['Fullname'],
        email: data['Email'],
        phoneNo: data['Phone'],
        profileImage: data['ProfileImage'],
        specialist: data['Specialist'],
        signature: data['Signature'], status: data['Status'], accountStatus: data['AccountStatus'], doctorRegisterationNo: data['DoctorRegisterationNo']);
  }
}
