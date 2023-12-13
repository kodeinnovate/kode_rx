import 'package:flutter/material.dart';
import 'package:kode_rx/components/custom_textfield.dart';
import 'app_colors.dart';

class Patient_info extends StatefulWidget {
 const Patient_info({super.key});

  @override
  State<Patient_info> createState() => _Patient_infoState();
}

class _Patient_infoState extends State<Patient_info> {
  final patientName = TextEditingController();
  final phoneNumber = TextEditingController();
  final pasthistory = TextEditingController();
  final agefeild = TextEditingController();
  String gender = 'male';

  void _handleRadioValueChange(String? value) {
    setState(() {
      gender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('patient info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextfield(
                    controller: patientName, hintText: 'Patient Name', keyboardType: TextInputType.name,),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                    controller: phoneNumber, hintText: 'Enter your Phone', keyboardType: TextInputType.phone,),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  controller: agefeild,
                  hintText: 'Enter your Age',
                   keyboardType: TextInputType.number,
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
                          groupValue: gender,
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
                          groupValue: gender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: const Text('Other'),
                        leading: Radio(
                          value: 'other',
                          groupValue: gender,
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
                    controller: pasthistory,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80),
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style:const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll( Size(200, 80)),
                        textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 20))
                      ),
                      child: const Text('Next'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
