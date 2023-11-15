import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'register.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  static OTPScreen get instance => Get.find();
  var otp;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter the verification code',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) {
                  print('auto submit');
                  otp = code;
                //   print(otp);
                //   // verifyOTP(otp);
                //   // Signup.instance.otpOnSubmit(otp);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    print('Clicked on the otp submit button');
                    // verifyOTP(otp);
                    print(otp);
                   Signup.instance.otpOnSubmit(otp);
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
