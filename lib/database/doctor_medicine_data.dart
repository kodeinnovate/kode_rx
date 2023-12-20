import 'package:cloud_firestore/cloud_firestore.dart';

class UserMedicineModel {
  final String? id;
  final String medicineName;
  final String medicineContent;
  final String medicineType;
  final List<String> medicineMgList;
  final String status;

  const UserMedicineModel(
      {this.id,
      required this.medicineName,
      required this.medicineContent,
      required this.medicineMgList,
      required this.medicineType,
      required this.status});

  toJson() {
    return {
      'MedicineContent': medicineContent,
      'MedicineName': medicineName,
      'MedicineType': medicineType,
      'MedicineMgList': medicineMgList,
      'Status': status
    };
  }

  factory UserMedicineModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserMedicineModel(
      id: document.id,
      medicineName: data['MedicineName'],
      medicineContent: data['MedicineContent'],
      medicineMgList: List<String>.from(data['MedicineMgList']),
      medicineType: data['MedicineType'],
      status: data['Status'],
    );
  }
}
