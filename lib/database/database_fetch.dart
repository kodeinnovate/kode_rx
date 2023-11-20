import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNo;

  const UserModel(
      {this.id,
      required this.fullname,
      required this.email,
      required this.phoneNo});

  toJson() {
    return {'Fullname': fullname, 'Email': email, 'Phone': phoneNo};
  }

// ---------  Data fetch --------- //
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullname: data['Fullname'],
        email: data['Email'],
        phoneNo: data['Phone']);
  }
}
