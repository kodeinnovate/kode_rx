import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNo;
  final String profileImage;
  final String signature;

  const UserModel(
      {this.id,
      required this.fullname,
      required this.email,
      required this.phoneNo,
      required this.profileImage,
      required this.signature});

  toJson() {
    return {
      'Fullname': fullname,
      'Email': email,
      'Phone': phoneNo,
      'ProfileImage': profileImage,
      'Signature': signature
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
        signature: data['Signature']);
  }
}
