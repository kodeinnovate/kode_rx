import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/home.dart';
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
  final fontSize = 14.0;
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
    } finally {}
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
        status: '1');
    await userRepository.addPatientDetails(
        userController.userId.value, patientData);
  }

  void pdfCreate(pw.Document doc) async {
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.SizedBox(height: 150.0),
          // pw.Row(
          //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          //   children: [dateTime(context)],
          // ),
          pw.SizedBox(height: 10.0),
          patientDetails(context),
          pw.SizedBox(height: 10.0),
          buildInvoice(context),
          pw.SizedBox(height: 10.0),
          pw.Divider(),

          pw.SizedBox(height: 10.0),
          pw.Text(
            'Additional Note',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: fontSize),
          ),
          pw.SizedBox(height: 10),
          pw.Text(notes!, style: pw.TextStyle(fontSize: fontSize)),
          pw.SizedBox(height: 5),
          //  pw.Image(image),
          // pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          //   if (signature(context) != null)
          //     signature(context)!
          //   else
          //     pw.Row(children: [
          //       pw.Text('Prescribed By: DR. ',
          //           style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontSize)),
          //       pw.Text(userController.currentLoggedInUserName.value,
          //           style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontSize))
          //     ]),
          // ]),

          // pw.SizedBox(height: 40),
          // pw.Align(
          //     alignment: pw.Alignment.bottomCenter,
          //     child: pw.Expanded(
          //     child: companyWaterMark(context))
          // )
        ],
        footer: (context) =>
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          if (signature(context) != null)
            signature(context)!
          else
            pw.Row(children: [
              pw.Text('Prescribed By: DR. ',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: fontSize)),
              pw.Text(userController.currentLoggedInUserName.value,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: fontSize))
            ]),
        ]),
        // footer: (context) => pw.Container(
        //   alignment: pw.Alignment.center,
        //   margin: pw.EdgeInsets.only(top: 10.0),
        //   child: pw.Row(
        //     mainAxisAlignment: pw.MainAxisAlignment.center,
        //     children: [
        //       pw.Text(
        //         'Prescription Generated By KodeRx',
        //         style:
        //             pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
        //       ),
        //       pw.SizedBox(width: 20), // Adjust the spacing between the texts
        //       pw.Text(
        //         'Powered By Kodeinnovate Solutions Pvt. Ltd.',
        //         style:
        //             pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  pw.Widget buildInvoice(pw.Context context) {
    final headers = ['Medicine', 'Routine', 'Before or after meal'];
    final data = selectedMedicines?.map((medicine) {
      return [
        '${medicine.name} ${medicine.mg == null || medicine.mg == '' ? '' : ' - ${medicine.mg}'}',
        medicine.timesToTake.isEmpty ? 'N/A' : medicine.timesToTake.join(', '),
        medicine.beforeMeal == ''
            ? ''
            : medicine.beforeMeal == 'before'
                ? 'Before Meal'
                : 'After Meal',
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data!,
      border: null,
      headerStyle:
          pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontSize),
      cellStyle: pw.TextStyle(fontSize: fontSize),
      headerDecoration: const pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
      },
    );
  }

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
                  '         ${userController.patientName.value}',
                  style: pw.TextStyle(
                      fontSize: fontSize, fontWeight: pw.FontWeight.normal),
                ),

                // companyWaterMark(context)
              ]),
          pw.SizedBox(height: 10),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(children: [
                        pw.Text(
                          '           ${userController.patientAge.value}',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal),
                        ),
                        pw.SizedBox(width: 20.0),
                        pw.Text(
                          'Gender: ${userController.patientGender.value}',
                          style: pw.TextStyle(
                              fontSize: fontSize,
                              fontWeight: pw.FontWeight.normal),
                        ),
                      ]),
                    ]),
                dateTime(context),
              ]),
          pw.SizedBox(height: 10),
          pw.Padding(padding: pw.EdgeInsets.only(left: 10),
          child: pw.Wrap(
            children: [
              pw.RichText(
                  text: pw.TextSpan(children: [
                pw.TextSpan(
                    text: 'History: ',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: fontSize)),
                pw.TextSpan(
                    text: userController.patientPastHistory.value,
                    style: pw.TextStyle(fontSize: fontSize)),
              ])),
              // pw.Text(
              //   'History: ${userController.patientPastHistory.value}',
              //   style: pw.TextStyle(
              //       fontSize: fontSize, fontWeight: pw.FontWeight.normal),
              // ),
            ],
          ),
          ),
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
            '    ${DateFormat.yMd().add_jm().format(currentDate)}',
            style: pw.TextStyle(
                fontSize: fontSize, fontWeight: pw.FontWeight.normal),
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
      pw.SizedBox(height: 8.0),
      pw.Row(children: [
        pw.Text('Prescribed By: DR. ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(userController.currentLoggedInUserName.value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ])
    ]);
  }
}
