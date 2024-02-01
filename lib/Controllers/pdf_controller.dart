import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PdfController extends GetxController {
  static PdfController get instance => Get.find();
  UserController userController = Get.put(UserController());

  List<Medicine>? selectedMedicines;
  String? notes;

  PdfController({required this.selectedMedicines, required this.notes});

  void addMedicine(List<Medicine> medicine) {
    selectedMedicines?.addAll(medicine);
  }

  DateTime currentDate = DateTime.now();

  // void removeMedicine(Medicine medicine) {
  //   selectedMedicines?.remove(medicine);
  // }

  // void clearMedicines() {
  //   selectedMedicines?.clear();
  // }

  void setNotes(String notes) {
    notes = notes;
  }

  Future<void> createAndDisplayPdf() async {
    print(userController.followUpDate.value);
    try {
      final doc = pw.Document();
      pdfCreate(doc); // PDF Layout creation Function
      Get.to(() => PreviewScreen(doc: doc));

      final pdfBytes = await doc.save();
      final pdfReference = await _uploadPdfToStorage(pdfBytes);

      // Save PDF URL to Firebase Database or any other storage
      await _savePdfUrlToDatabase(pdfReference);
    } catch (e) {
      print(e);
      Get.snackbar('Something went wrong', 'Error loading the PDF');
    } finally {
      userController.chiefComplaints.value = <String>[];
      userController.findings.value = <String>[];
      userController.diagnosis.value = <String>[];
      userController.investigation.value = <String>[];
      userController.followUpDate.value = '';
    }
  }

  Future<String> _uploadPdfToStorage(Uint8List pdfBytes) async {
    final fileName =
        'prescription_${userController.currentLoggedInUserName.value}_${userController.patientName.value}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('pdf_file/$fileName');

    final uploadTask = storageReference.putData(pdfBytes);
    await uploadTask.whenComplete(() => print('PDF uploaded'));

    return await storageReference.getDownloadURL();
  }

  Future<void> _savePdfUrlToDatabase(String pdfUrl) async {
    // Save the URL to Firebase Database or any other storage
    // This is just an example, you need to implement your own logic
    print('PDF URL: $pdfUrl');
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().add_jm().format(currentDate);
    final patientData = PatientModel(
        patientName: userController.patientName.value,
        patientAge: userController.patientAge.value,
        patientGender: userController.patientGender.value,
        pastHistory: userController.patientPastHistory.value,
        phoneNumber: userController.patientPhoneNo.value,
        date: formattedDate,
        pdfUrl: pdfUrl,
        diagnosisDetails: userController.diagnosisDetails.value,
        // pastmedicalHistoryDetails: userController.pastmedicalHistoryDetails.value,
        treatmentDetails: userController.treatmentDetails.value,
        status: '1');
    await userRepository.addPatientDetails(
        userController.userId.value, patientData);
  }

  void pdfCreate(pw.Document doc) async {
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.SizedBox(height: 90.0),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [buildTitle(context), dateTime(context)]),
          pw.SizedBox(height: 10.0),
          patientDetails(context),
          pw.SizedBox(height: 10.0),
          buildInvoice(context),
          pw.SizedBox(height: 10.0),
          pw.Divider(),

          pw.SizedBox(height: 10.0),
          if (userController.followUpDate.value != '') followUpDate(context),
          pw.SizedBox(height: 10.0),
          pw.Text(
            'Additional Note',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text(notes!),
          pw.SizedBox(height: 5),
          //  pw.Image(image),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            if (signature(context) != null)
              signature(context)!
            else
              pw.Row(children: [
                pw.Text('Prescribed By: DR. ',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(userController.currentLoggedInUserName.value,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
              ]),
          ]),

          // pw.SizedBox(height: 40),
          // pw.Align(
          //     alignment: pw.Alignment.bottomCenter,
          //     child: pw.Expanded(
          //     child: companyWaterMark(context))
          // )
        ],
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: pw.EdgeInsets.only(top: 10.0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'Prescription Generated By KodeRx',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
              ),
              pw.SizedBox(width: 20), // Adjust the spacing between the texts
              pw.Text(
                'Powered By Kodeinnovate Solutions Pvt. Ltd.',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pw.Widget buildInvoice(pw.Context context) {
    final headers = ['Medicine', 'Routine', 'Before or after meal', 'Duration'];
    final data = selectedMedicines?.map((medicine) {
      return [
        '${medicine.name} ${medicine.mg == null || medicine.mg == '' ? '' : ' - ${medicine.mg}'}',
        medicine.timesToTake.isEmpty ? 'N/A' : medicine.timesToTake.join(', '),
        medicine.beforeMeal ? 'Before Meal' : 'After Meal',
        medicine.days == '0' || medicine.days == null
            ? 'Not Specified'
            : (medicine.days == '1'
                ? '${medicine.days} ${medicine.daysType}'
                : '${medicine.days} ${medicine.daysType}s')
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data!,
      border: null,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center
      },
    );
  }

  pw.Widget followUpDate(pw.Context context) => pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Text('Follow-up date: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
        pw.Text(userController.followUpDate.value, style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 14)),
      ]);

  pw.Widget buildTitle(pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Rx',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
        ],
      );

  pw.Widget patientDetails(pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Name: ${userController.patientName.value}',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.normal),
                ),

                // companyWaterMark(context)
              ]),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  pw.Text(
                    'Age: ${userController.patientAge.value}',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  ),
                  pw.SizedBox(width: 20.0),
                  pw.Text(
                    'Gender: ${userController.patientGender.value}',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.normal),
                  ),
                ]),
              ]),

         
          pw.Wrap(spacing: 1.0, children: [
            if (userController.chiefComplaints.isNotEmpty)
            // pw.RichText(text: pw.TextSpan(children: <pw.TextSpan>[
            //   pw.TextSpan(
            //     text: 'Chief Complaints: ',
            //     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)
            //   ),
            //   pw.TextSpan(text: userController.chiefComplaints.toList().join(', ')),
            // ])),

              pw.Text(
                  'Chief Complaints: ${userController.chiefComplaints.toList().join(', ')}'),
          ]),
          pw.Wrap(spacing: 1.0, children: [
            if (userController.findings.isNotEmpty)
              pw.Text(
                  'Findings: ${userController.findings.toList().join(', ')}'),
          ]),
          pw.Wrap(children: [
            if (userController.diagnosis.isNotEmpty)
              pw.Text(
                  'Diagnosis: ${userController.diagnosis.toList().join(', ')}'),
          ]),
          pw.Wrap(children: [
            if (userController.investigation.isNotEmpty)
              pw.Text(
                  'Investigation: ${userController.investigation.toList().join(', ')}')
          ]),
          // pw.Wrap(
          //   children: [
          //     pw.RichText(
          //       text: pw.TextSpan(children: <pw.TextSpan>[
          //         pw.TextSpan(
          //             text: 'History: ',
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.bold)),
          //         pw.TextSpan(
          //             text: userController.patientPastHistory.value,
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.normal))
          //       ]),
          //     ),
          //     pw.RichText(
          //       text: pw.TextSpan(children: <pw.TextSpan>[
          //         pw.TextSpan(
          //             text: 'Diagnosis: ',
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.bold)),
          //         pw.TextSpan(
          //             text: userController.diagnosisDetails.value,
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.normal))
          //       ]),
          //     ),
          //     pw.RichText(
          //       text: pw.TextSpan(children: <pw.TextSpan>[
          //         pw.TextSpan(
          //             text: 'Treatment: ',
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.bold)),
          //         pw.TextSpan(
          //             text: userController.treatmentDetails.value,
          //             style: pw.TextStyle(
          //                 fontSize: 14, fontWeight: pw.FontWeight.normal))
          //       ]),
          //     ),
          //   ],
          // ),
        ],
      );

  pw.Widget dateTime(pw.Context context) => pw.Column(
        //  String formattedDate = DateFormat.yMMMMd().add_jm().format(currentDate);
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // pw.Text(
          //   'Date:',
          //   style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          // ),
          pw.Text(
            'Date: ${DateFormat.yMd().add_jm().format(currentDate)}',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.normal),
          ),
        ],
      );

  // pw.Widget signature(pw.Context context) => pw.Column(children: [
  //       pw.Image(
  //         pw.MemoryImage(userController.signatureStoreInBytes.value!),
  //         width: 100,
  //         height: 100,
  //       ),
  //       pw.SizedBox(height: 16.0),
  //       pw.Row(children: [
  //         pw.Text('Prescribed By: DR. ',
  //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.Text(userController.currentLoggedInUserName.value,
  //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
  //       ])
  //     ]);

  pw.Widget? signature(pw.Context context) {
    final signatureBytes = userController.signatureStoreInBytes.value;

    // Check if signatureBytes is null, and return null if true
    if (signatureBytes == null) {
      return null;
    }

    return pw.Column(children: [
      pw.Image(
        pw.MemoryImage(signatureBytes),
        width: 100,
        height: 100,
      ),
      pw.SizedBox(height: 16.0),
      pw.Row(children: [
        pw.Text('Prescribed By: DR. ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(userController.currentLoggedInUserName.value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ])
    ]);
  }
}
