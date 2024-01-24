import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/additional_info.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';

class Patient_info extends StatefulWidget {
  const Patient_info({super.key});
  static Patient_info get instance => Get.find();

  @override
  State<Patient_info> createState() => _Patient_infoState();
}

class _Patient_infoState extends State<Patient_info> {
  final userRepository = Get.put(UserRepo());
  UserController userController = Get.put(UserController());
  final patientName = TextEditingController();
  final phoneNumber = TextEditingController();
  final pastHistory = TextEditingController();
  final patientAge = TextEditingController();
  String patientGender = 'male';

  void _handleRadioValueChange(String? value) {
    setState(() {
      patientGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: GestureDetector(
            onTap: () {
              // Close the keyboard when tapped anywhere on the screen
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: DeviceHelper.deviceAppBar(title: 'Patient Information'),
              body: GestureDetector(
                onTap: () {
                  // Close the keyboard when tapped anywhere on the screen
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextfield(
                          controller: patientName,
                          hintText: 'Patient Name',
                          keyboardType: TextInputType.name,
                          obsecureText: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextfield(
                          controller: phoneNumber,
                          hintText: 'Enter your Phone',
                          keyboardType: TextInputType.phone,
                          obsecureText: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextfield(
                          controller: patientAge,
                          hintText: 'Enter your Age',
                          obsecureText: false,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'Select your gender',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text('Male',style:TextStyle(fontSize: 12)),
                                value: 'male',
                                groupValue: patientGender,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text('Female',style:TextStyle(fontSize: 12)),
                                value: 'female',
                                groupValue: patientGender,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: const Text('Other',style:TextStyle(fontSize: 12)),
                                value: 'other',
                                groupValue: patientGender,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            style: const TextStyle(
                                fontSize:
                                    18), // Set the font size for the input text
                            controller: pastHistory,
                            maxLines: 4,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.customBackground),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: 'Past History',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize:
                                      14), // Set the font size for the placeholder
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButtom(
                            buttonText: 'Next', onTap: patientDataStore),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Future<void> patientDataStore() async {
    // print(patientName.text.toString().trim());
    //               print(patientAge.text.toString().trim());
    //               print(pastHistory.text.toString().trim());
    //               print(patientGender);
    //               print(phoneNumber.text.toString().trim());

    userController.patientName.value = patientName.text.toString().trim();
    userController.patientAge.value = patientAge.text.toString().trim();
    userController.patientGender.value = patientGender;
    userController.patientPhoneNo.value = phoneNumber.text.toString().trim();
    userController.patientPastHistory.value =
        pastHistory.text.toString().trim();
    // print(userController.userId.value);
    // print(userController.patientName.value);
    // final patientData = PatientModel(
    //   patientName: patientName.text.toString().trim(),
    //   patientAge: patientAge.text.toString().trim(),
    //   patientGender: patientGender,
    //   pastHistory: pastHistory.text.toString().trim(),
    //   phoneNumber: phoneNumber.text.toString().trim()
    // );
    // await userRepository.addPatientDetails(userController.userId.value, patientData);
    if (userController.patientName.value.isNotEmpty) {
      Get.to(() => AdditionalInfo());
    } else {
      Get.snackbar('Name Field Empty', 'Please add a name');
    }
  }
}
