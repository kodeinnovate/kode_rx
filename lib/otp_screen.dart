import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/device_helper.dart';
import 'register.dart';

class OTPScreen extends StatelessWidget {
  static OTPScreen get instance => Get.find();
   final AuthOperation authOperation;

  OTPScreen(this.authOperation, {super.key});
    UserController userController = Get.put(UserController());
  // ignore: prefer_typing_uninitialized_variables
  var otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'OTP Verification'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),

              const Text(
                'OTP',
                style: TextStyle(fontSize: 40, color: AppColors.customBackground),
                textAlign: TextAlign.center,
              ),
              Text(
                '$loginPhoneNumber',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'assets/images/OTP_image.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(
                height: 20.0,
              ),
             const Text(
                'Verfication Code',
                style: TextStyle(fontSize: 26),
              ),
              
              Container(
                alignment: Alignment.center,
                width: 260,
                child: const Text(
                  'We have sent a verification code to your mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                focusedBorderColor: AppColors.customBackground,
                cursorColor: AppColors.customBackground,
                autoFocus: true,
                showFieldAsBox: true,
                fieldWidth: 50,
                borderWidth: 1,
                // borderColor: AppColors.customBackground,
                enabledBorderColor: AppColors.customBackground,
        
                // enabledBorderColor: AppColors.customBackground,
                // decoration: InputDecoration(
                //               filled: true,
                //               fillColor: Color.fromARGB(255, 218, 218, 218),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(
                //                     color: AppColors.customBackground),
                //                 borderRadius: BorderRadius.circular(7.7),
                //               ),
                //             ),
                onSubmit: (code) {
                  print('auto submit');
                  otp = code;
                   
                  Signup.instance.otpOnSubmit(otp, authOperation);
                  //   print(otp);
                  //   // verifyOTP(otp);
                  //   // Signup.instance.otpOnSubmit(otp);
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              CustomButtom(buttonText: 'Submit', onTap: () => {Signup.instance.otpOnSubmit(otp, authOperation)}),
              // ElevatedButton(
              //     onPressed: () {
              //       print('Clicked on the otp submit button');
              //       // verifyOTP(otp);
              //       print(otp);
              //       //  Signup.instance.otpOnSubmit(otp, authOperation);
              //     },
              //     child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
