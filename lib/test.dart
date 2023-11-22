import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'device_helper.dart';

class OtpPage extends StatelessWidget {
  String title = 'OTP Verification';


  OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: DeviceHelper.deviceAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 46,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'OTP',
                    style: TextStyle(fontSize: 29),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/OTP_image.png',
                  height: 300,
                  width: 300,
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Verfication Code',
                  style: TextStyle(fontSize: 20),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                    alignment: Alignment.center,
                    width: 260,
                    child: Text(
                      'We have sent a verification code to your mobile number',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )),
              )),
            const  SizedBox(
                height: 10,
              ),
              // Container(
              //   // height: 200,
              //   alignment: Alignment.center,
              //   child: Form(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 16.0, vertical: 12),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: List.generate(
              //           4,
              //           (index) => SizedBox(
              //             height: 58,
              //             width: 58,
              //             child: TextField(
              //               decoration: InputDecoration(
              //                 filled: true,
              //                 fillColor: Color.fromARGB(255, 218, 218, 218),
              //                 enabledBorder: OutlineInputBorder(
              //                   borderSide: BorderSide(
              //                       color: AppColors.customBackground),
              //                   borderRadius: BorderRadius.circular(7.7),
              //                 ),
              //               ),
              //               controller: controllers[index],
              //               autofocus: index == 0,
              //               focusNode: focusNodes[index],
              //               onChanged: (value) {
              //                 if (value.isNotEmpty) {
              //                   if (index < 3) {
              //                     focusNodes[index + 1].requestFocus();
              //                   } else {
              //                     // Last digit entered, you can perform any action here
              //                   }
              //                 } else if (value.isEmpty) {
              //                   focusNodes[index - 1].requestFocus();
              //                 }
              //               },
              //               onSubmitted: (String value) {
              //                   Navigator.of(context).pushReplacementNamed('/patientHome');
              //                 },
              //               onEditingComplete: () {
              //                 print('done');
              //                 // Handle completion if needed
              //               },
              //               style: Theme.of(context).textTheme.titleLarge,
              //               keyboardType: TextInputType.number,
              //               textAlign: TextAlign.center,
              //               inputFormatters: [
              //                 LengthLimitingTextInputFormatter(1),
              //                 FilteringTextInputFormatter.digitsOnly,
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                child: Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.customBackground,
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );}}