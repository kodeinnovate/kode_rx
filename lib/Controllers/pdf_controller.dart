import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
    // final patientName = userController.patientName.value;
    // final patientAge = userController.patientAge.value;
    // final pastHistory = userController.patientPastHistory.value;
    // final patientGender = userController.patientGender.value;
    // final patientPhoneNo = userController.patientPhoneNo.value;
    // print(
    //     '$patientName, $patientAge, $pastHistory, $patientPhoneNo, $patientGender');

    // print('selected Medicine $selectedMedicines');
    // print('note $notes');
    if (selectedMedicines == null || selectedMedicines!.isEmpty) {
      Get.snackbar('No medicine Added', 'Error');
    } else {
      final doc = pw.Document();
      pdfCreate(doc); // PDF Layout creation Function
      Get.to(() => PreviewScreen(doc: doc));
    }
  }

  void pdfCreate(pw.Document doc) {
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.SizedBox(height: 90.0),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [buildTitle(context), dateTime(context)]),
          pw.SizedBox(height: 20.0),
          patientDetails(context),
          pw.SizedBox(height: 20.0),
          buildInvoice(context),
          pw.SizedBox(height: 20.0),
          pw.Divider(),
          pw.SizedBox(height: 10.0),
          pw.Text(
            'Additional Note',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text(notes!),
        ],
      ),
    );
  }

  pw.Widget buildInvoice(pw.Context context) {
    final headers = ['Medicine', 'Routine', 'Before or after meal'];
    final data = selectedMedicines?.map((medicine) {
      return [
        medicine.name,
        medicine.timesToTake.isEmpty ? 'N/A' : medicine.timesToTake.join(', '),
        medicine.beforeMeal ? 'Before Meal' : 'After Meal',
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data!,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
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
          pw.Text(
            'Name: ${userController.patientName.value}',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal),
          ),
          pw.Row(children: [
          pw.Text(
            'Age: ${userController.patientAge.value}',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal),
          ),
          pw.SizedBox(width: 20.0),
          pw.Text(
            'Gender: ${userController.patientGender.value}',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal),
          ),

          ]),
          pw.Wrap(
            children: [
              pw.Text(
                'History: ${userController.patientPastHistory.value}',
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.normal),
              ),
            ],
          ),
        ],
      );

  pw.Widget dateTime(pw.Context context) => pw.Column(
        //  String formattedDate = DateFormat.yMMMMd().add_jm().format(currentDate);
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Date:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            DateFormat.yMd().add_jm().format(currentDate),
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal),
          ),
        ],
      );
}
