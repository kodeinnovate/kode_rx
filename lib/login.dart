import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/otp_screen.dart';
import 'package:kode_rx/register.dart';

import 'app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static LoginScreen get instance => Get.find();
  UserController userController = Get.put(UserController());

  final _userRepo = Get.put(UserRepo());
  final countryCode = '+91';

  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset('assets/images/kodeinnovate.png',
                              width: 50.0, height: 50.0),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('NEORx',
                                style: TextStyle(
                                    fontSize: 44.0, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double spacing;
                      if (constraints.maxWidth < 600) {
                        // Mobile mode
                        spacing = 133.0;
                      } else {
                        // Tablet mode or larger
                        spacing = 273.0;
                      }

                      return SizedBox(
                          height: spacing); // Add space below the top elements
                    },
                  ),
                  // Add the login_image here
                  Image.asset('assets/images/login_image.png',
                      fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        // Other container properties...
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Phone Number ',
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                TextSpan(text: 'To Get Started'),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 15.0)),
                          Container(
                            // alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              border: Border.all(
                                color: Colors.black38, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.number,
                              onSubmitted: (String value) async {
                                if (phoneNumberController.text
                                    .toString()
                                    .isNotEmpty) {
                                  print(
                                      '$countryCode${phoneNumberController.text.toString().trim()}');
                                  String enteredPhoneNumber =
                                      phoneNumberController.text
                                          .toString()
                                          .trim();
                                  UserModel? user =
                                      await _userRepo.getUserDetails(
                                          '$countryCode$enteredPhoneNumber');
                                  print('$countryCode$enteredPhoneNumber');
                                  if (user != null &&
                                      user.phoneNo ==
                                          '$countryCode$enteredPhoneNumber') {
                                    // Phone number exists and matches, navigate to OTP page
                                     loginPhoneNumber.value =
                                        '$countryCode$enteredPhoneNumber';
                                    print('Go to OTP page');
                                    AuthOperation.signIn;
                                    AuthenticationRepo.instance
                                        .phoneAuthentication(
                                            '$countryCode$enteredPhoneNumber');

                                    Get.to(
                                        () => OTPScreen(AuthOperation.signIn));
                                  } else {
                                    print('Go to the Registeration page');
                                    loginPhoneNumber.value =
                                        '$countryCode$enteredPhoneNumber';
                                    Get.to(() => Signup());
                                    Get.snackbar('Phone Number Not Registered!',
                                      'Please Create your account', barBlur: 10, backgroundColor: Colors.red.withOpacity(0.9), icon: Icon(Icons.warning_amber_outlined), margin: EdgeInsets.only(top: 20.0), colorText: Colors.white, duration: Duration(seconds: 5));
                    
                                  }
                                } else {
                                  Get.snackbar('No Phone Number Added!',
                                      'Please add your phone number', barBlur: 10, backgroundColor: Colors.white.withOpacity(0.6), icon: Icon(Icons.warning_amber_outlined), margin: EdgeInsets.only(top: 20.0));
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter your phone number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
