import 'package:cloud_firestore/cloud_firestore.dart';

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
  final List<String>? findings;
  final List<String>? diagnosis;
  final List<String>? investigation;
  final List<String>? chiefComplaints;

  const UserModel(
      {this.id,
      required this.fullname,
      required this.email,
      required this.phoneNo,
      required this.profileImage,
      required this.signature,
      required this.specialist,
      this.status,
      this.accountStatus,
      this.doctorRegisterationNo,
      this.findings,
      this.diagnosis,
      this.investigation,
      this.chiefComplaints
      });

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
      'DoctorRegisterationNo': doctorRegisterationNo,
      'Findings': findings,
      'Diagnosis': diagnosis,
      'Investigation': investigation,
      'ChiefComplaints': chiefComplaints,
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
        signature: data['Signature'],
        status: data['Status'],
        accountStatus: data['AccountStatus'],
        doctorRegisterationNo: data['DoctorRegisterationNo'],
        findings: List<String>.from(data['Findings']),
        diagnosis: List<String>.from(data['Diagnosis']),
        investigation: List<String>.from(data['Investigation']),
        chiefComplaints: List<String>.from(data['ChiefComplaints']),
        );
  }
}
