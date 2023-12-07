import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  final String? id;
  final String medicineName;
  final String medicineDetails;

  const MedicineModel(
      {this.id,
      required this.medicineName,
      required this.medicineDetails});

  toJson() {
    return {'MedicineDetails': medicineDetails, 'MedicineName': medicineName};
  }

// --------- Medicine Data fetch --------- //
  factory MedicineModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MedicineModel(
        id: document.id,
        medicineName: data['MedicineName'],
        medicineDetails: data['MedicineDetails'],);
  }
}
