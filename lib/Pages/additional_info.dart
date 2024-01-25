import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Pages/additional_assessments.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';

class AdditionalInfo extends StatelessWidget {
  AdditionalInfo({super.key});
  static AdditionalInfo get instance => Get.find();
  UserController userController = Get.put(UserController());

  // final pastmedicalHistoryController = TextEditingController();
  final diagnosisDetailsController = TextEditingController();
  final treatmentDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Additional Details'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // CustomTextfield(
              //   controller: pastmedicalHistoryController,
              //   hintText: 'Past Medical hsitory',
              //   keyboardType: TextInputType.name,
              //   obsecureText: false,
              //   maxLines: 6,
              // ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: diagnosisDetailsController,
                hintText: 'Diagnosis',
                keyboardType: TextInputType.name,
                obsecureText: false,
                maxLines: 6,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: treatmentDetailsController,
                hintText: 'Treatment Done',
                keyboardType: TextInputType.name,
                obsecureText: false,
                maxLines: 6,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButtom(buttonText: 'Next', onTap: additionalDataStore)
            ],
          ),
        ),
      ),
    );
  }

  void additionalDataStore() {
    // userController.pastmedicalHistoryDetails.value =
    //     pastmedicalHistoryController.text.toString().trim();
    userController.diagnosisDetails.value =
        diagnosisDetailsController.text.toString().trim();
    userController.treatmentDetails.value =
        treatmentDetailsController.text.toString().trim();
    Get.to(() => AdditionalAssessments());
  }
}
