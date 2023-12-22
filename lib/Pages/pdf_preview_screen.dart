import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/alert_dialogue.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/home.dart';
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
    Future<bool> showExitPopup() async {
      return await showDialog(
              context: Get.overlayContext!,
              builder: (context) => CustomDialog(
                    dialogTitle: 'Confirm',
                    dialogMessage:
                        'Are you sure you wanna go back to the home screen?',
                    onLeftButtonPressed: () => Navigator.of(context).pop(false),
                    onRightButtonPressed: () => Get.offAll(() => HomeScreen()),
                  )
              ) ??
          false;
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    return Scaffold(
        appBar: DeviceHelper.deviceAppBar(title: 'Preview'),
        body: WillPopScope(
          onWillPop: showExitPopup,
          child: PdfPreview(
            padding: const EdgeInsets.only(top: 40.0),
            build: (format) => doc.save(),
            allowPrinting: true,
            allowSharing: true,
            initialPageFormat: PdfPageFormat.a4,
            pdfFileName: '$fileName.pdf',
            canChangeOrientation: false,
            canDebug: false,
          ),
        ));
  }
}
