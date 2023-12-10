import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFGenerator extends StatefulWidget {
  static PDFGenerator get instance => Get.find();
  final List<Medicine>? selectedMedicines;
  final String? notes;
  const PDFGenerator({super.key, this.selectedMedicines, this.notes});
  @override
  State<PDFGenerator> createState() => _PDFGeneratorState();
}

class _PDFGeneratorState extends State<PDFGenerator> {
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'PDF Print and Viewing'),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: _displayPdf,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customBackground),
                    child: const Text(
                      'View PDF',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )),
              const SizedBox(
                height: 100.0,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: _createPdf,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customBackground),
                    child: const Text(
                      'Print PDF',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }

// Repeated function to print or view pdf, so made it saperate, used in _createPdf() and _displayPdf() functions
  void pdfCreate(doc) {
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.SizedBox(
            height: 90.0,
          ),
          buildTitle(context),
          pw.SizedBox(
            height: 20.0,
          ),
          buildInvoice(context),
          pw.SizedBox(height: 20.0),
          pw.Divider(),
          pw.SizedBox(
            height: 10.0,
          ),
          pw.Text('Additional Note',
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(widget.notes ?? 'N/A')
        ],
      ),
    );
  }

// This function takes you to the devices default print screen where you can print the PDF
  void _createPdf() async {
    final doc = pw.Document();
    pdfCreate(doc); //PDF Layout creation Function
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

//This function creates the PDF documents and displays it properly on the another screen
  void _displayPdf() {
    final doc = pw.Document();
    pdfCreate(doc); //PDF Layout creation Function
    Get.to(() => PreviewScreen(doc: doc));
  }

  pw.Widget buildInvoice(pw.Context context) {
    // Table's bold heading or Catagories
    final headers = ['Medicine', 'Routine', 'Before or after meal'];

    // Data for that Particular heading
    final data = widget.selectedMedicines!.map((medicine) {
      return [
        medicine.name,
        medicine.timesToTake.isEmpty ? 'N/A' : medicine.timesToTake.join(', '),
        medicine.beforeMeal ? 'Before Meal' : 'After Meal'
      ];
    }).toList();
    // Table Layout
    return pw.TableHelper.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        cellHeight: 30,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.center,
          2: pw.Alignment.center
        });
  }
}

pw.Widget buildTitle(pw.Context context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Rx',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        )
      ],
    );

// buildTitle(pw.Context context) {
//   const Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Invice',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       )
//     ],
//   );

//   void _displayPdf() {
//     final doc = pw.Document();

//     doc.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//             final medicinesText = widget.selectedMedicines?.map((medicine) {
//             return 'Medicine Name: ${medicine.name}\n' +
//                 'Times to take: ${medicine.timesToTake.join(', ')}\n' +
//                 'When to take: ${medicine.beforeMeal ? 'Before Meal' : 'After Meal'}\n' +
//                 '-----------------------------';
//           }).join('\n\n') ?? '';
//             return
//             pw.Padding(padding: pw.EdgeInsets.all(5.0), child: pw.Text(medicinesText));
//           // return pw.Column(
//           //   mainAxisAlignment: pw.MainAxisAlignment.start,
//           //   crossAxisAlignment: pw.CrossAxisAlignment.start,
//           //     if (widget.selectedMedicines != null)
//           //       for (var medicine in widget.selectedMedicines!)
//           //   children: [
//           //         pw.Text(
//           //           medicine.name,
//           //           style: pw.TextStyle(fontSize: 16),
//           //         ),
//           //         pw.Text(
//           //           medicine.name,
//           //           style: pw.TextStyle(fontSize: 16),
//           //         ),
//           //   ],
//           // );
//         },
//       ),
//     );
// // userController.printSelectedMedicines();
//     Get.to(() => PreviewScreen(doc: doc));
//   }
// }



