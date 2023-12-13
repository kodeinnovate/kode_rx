import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/app_colors.dart';
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
      home: Scaffold(
        appBar: DeviceHelper.deviceAppBar(title: 'Patient info'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextfield(
                    controller: patientName, hintText: 'Patient Name', keyboardType: TextInputType.name, obsecureText: false,),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                    controller: phoneNumber, hintText: 'Enter your Phone', keyboardType: TextInputType.phone, obsecureText: false,),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  controller: patientAge,
                  hintText: 'Enter your Age',
                    obsecureText: false, keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Select your gender',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black, 
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: ListTile(
                        title: const Text('Male'),
                        leading: Radio(
                          value: 'male',
                          groupValue: patientGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: const Text(
                          'Female',
                        ),
                        leading: Radio(
                          value: 'female',
                          groupValue: patientGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: const Text('Other'),
                        leading: Radio(
                          value: 'other',
                          groupValue: patientGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    style: const TextStyle(fontSize: 30),
                    controller: pastHistory,
                    maxLines: 4,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.customBackground),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Past History',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),
                const SizedBox(height: 30),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(80),
                //     child: ElevatedButton(
                //       onPressed: () {
                        
                //       },
                //       style:const ButtonStyle(
                //         minimumSize: MaterialStatePropertyAll( Size(200, 80)),
                //         textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 20))
                //       ),
                //       child: const Text('Next'),
                //     ),
                //   ),
                // ),
                CustomButtom(buttonText: 'Next', onTap: patientDataStore),
              ],
            ),
          ),
        ),
      ),
      
    );
    
  }
  Future<void> patientDataStore() async {
    print(patientName.text.toString().trim());
                  print(patientAge.text.toString().trim());
                  print(pastHistory.text.toString().trim());
                  print(patientGender);
                  print(phoneNumber.text.toString().trim());
    final patientData = PatientModel(
      patientName: patientName.text.toString().trim(),
      patientAge: patientAge.text.toString().trim(),
      patientGender: patientGender,
      pastHistory: pastHistory.text.toString().trim(),
      phoneNumber: phoneNumber.text.toString().trim()
    );
    Get.to(() => MedicationReminderApp());
    // await userRepository.addPatientDetails(patientData);
  }
}
