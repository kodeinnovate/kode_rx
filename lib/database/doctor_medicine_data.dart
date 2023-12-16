import 'package:cloud_firestore/cloud_firestore.dart';

class UserMedicineModel {
  final String? id;
  final String medicineName;
  final String medicineContent;
  final String medicineType;
  final String medicineMg;
  final String status;

  const UserMedicineModel(
      {this.id,
      required this.medicineName,
      required this.medicineContent,
      required this.medicineMg,
      required this.medicineType,
      required this.status});

  toJson() {
    return {
      'MedicineContent': medicineContent,
      'MedicineName': medicineName,
      'MedicineType': medicineType,
      'MedicineMg': medicineMg,
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
      medicineMg: data['MedicineMg'],
      medicineType: data['MedicineType'],
      status: data['Status'],
    );
  }
}
