import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/otp_screen.dart';
import 'verification_id.dart';
import 'Controllers/authentication_repo.dart';

class Signup extends StatelessWidget {
  static Signup get instance => Get.find();
  final userRepository = Get.put(UserRepo());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  // final _auth = FirebaseAuth.instance;
  // late final Rx<User?> firebaseUser;

  // void data(String userName, String email, String number) {
  //   var myInt = int.parse(number);
  //   assert(myInt is int);
  //   print(myInt); // 12345
  //   print(userName);
  //   print(email);
  //   print(number);
  // }

  // Future<void> phoneAuthentication(String number) async {
  //   print(number);
  //   try {
  //     print('called1');
  //     await _auth.verifyPhoneNumber(phoneNumber: number, verificationCompleted: (credential) async {
  //     await _auth.signInWithCredential(credential);
  //   },codeSent: (verificationId, resendToken) {
  //     print('called2');
  //     verificationID.value = verificationId;
  //     print('Verification ID set: $verificationId');
  //     print(verificationID.value);
  //   },codeAutoRetrievalTimeout: (verificationId) {
  //     verificationID.value = verificationId;
  //   },
  //    verificationFailed: (e) {
  //     if (e.code == 'invalid-phone-number') {
  //       Get.snackbar('Error', 'The provided phone number is not valid.');
  //     } else {
  //       Get.snackbar('Error', 'Something went wrong. Try again.');
  //     }
  //   },   timeout: const Duration(seconds: 120));
  //   } catch (e) {
  //     print('Error during phone authentication: $e');
  //   Get.snackbar('Error', 'Something went wrong. Try again.');
  //   }

  // }

  // Future<bool> verifyOTP(String otp) async {
  //   print(verificationID.value);
  //   print("final verification ${otp} ${verificationID.value}");
  //   var credentials = await _auth.signInWithCredential(
  //       PhoneAuthProvider.credential(verificationId: verificationID.value, smsCode: otp));
  //   return credentials.user != null ? true : false;
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.cloud_outlined,
                    size: 100,
                    color: AppColors.customBackground,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 42, color: AppColors.customBackground),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            "Enter your name, email and phone number for signup.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextfield(
                    controller: usernameController,
                    hintText: 'Enter your full name',
                    obsecureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: emailController,
                    hintText: 'Enter your email',
                    obsecureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: phoneNumberController,
                    hintText: 'Enter your phone number',
                    obsecureText: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtom(
                    buttonText: 'SIGN UP',
                    onTap: signUserUp,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Having trouble signing up?',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                            color: AppColors.customBackground, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUserUp() {
    print('Working');
    final user = UserModel(
      fullname: usernameController.text.trim(),
      email: emailController.text.trim(),
      phoneNo: phoneNumberController.text.toString().trim(),
    );
    // data(usernameController.text.toString(), emailController.text.toString(),
    //     phoneNumberController.text.toString());
    // phoneAuthentication(phoneNumberController.text.toString());
    dataStore(user);
    AuthenticationRepo.instance.phoneAuthentication(phoneNumberController.text.toString());
    Get.to(() => OTPScreen());
    //  Navigator.of(context).push(
    //                         MaterialPageRoute<void>(
    //                           builder: (BuildContext context) {
    //                             // Replace `DestinationScreen` with your actual destination screen widget
    //                             return OTPScreen();
    //                           },
    //                         ),
    //                       );
  }

  Future<void> dataStore(UserModel user) async {
    print('Working dataStore');
    await userRepository.createUser(user);
    // AuthenticationRepo.instance.phoneAuthentication(phoneNumberController.text.toString().trim());
  }

  void otpOnSubmit(String otp) async {
    print('function is working');
    // var isVerified = await verifyOTP(otp);
    var isVerified = await AuthenticationRepo.instance.verifyOTP(otp);
    print('working further');
    isVerified ? Get.to(HomeScreen()) : Get.to(Signup());
  }
}
