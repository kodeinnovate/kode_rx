import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:kode_rx/app_colors.dart';

class PreviewScreen extends StatelessWidget {
  static PreviewScreen get instance => Get.find();
  final pw.Document doc;
  const PreviewScreen({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Preview'),
      body: PdfPreview(
        padding: const EdgeInsets.only(top: 40.0),
        build: (format) => doc.save(),
        allowPrinting: true,
        allowSharing: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'test.pdf',
        canChangeOrientation: false,
        canDebug: false,
      
      ),
    );
  }
}
