import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String? id;
  final String patientName;
  final String phoneNumber;
  final String pastHistory;
  final String patientAge;
  final String patientGender;
  final String date;
  final String? pdfUrl;
  final String? status;

  const PatientModel(
      {this.id,
      required this.patientName,
      required this.phoneNumber,
      required this.pastHistory,
      required this.patientAge,
      required this.patientGender,
      required this.date, this.pdfUrl, this.status});

  toJson() {
    return {
      'PatientName': patientName,
      'PatientPhoneNumber': phoneNumber,
      'PatientHistory': pastHistory,
      'PatientAge': patientAge,
      'PatientGender': patientGender,
      "Date": date,
      'PdfUrl': pdfUrl,
      'Status': status
    };
  }


  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PatientModel(
      id: document.id,
      patientName: data['PatientName'],
      phoneNumber: data['PatientPhoneNumber'],
      pastHistory: data['PatientHistory'],
      patientAge: data['PatientAge'],
      patientGender: data['PatientGender'],
      date: data['Date'], pdfUrl: data['PdfUrl'], status: data['Status']
    );
  }
}
