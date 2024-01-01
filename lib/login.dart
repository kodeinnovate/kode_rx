import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/alert_dialogue.dart';
import 'package:kode_rx/Controllers/authentication_repo.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/privacy_policy_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/otp_screen.dart';
import 'package:kode_rx/register.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'app_colors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static LoginScreen get instance => Get.find();
  UserController userController = Get.put(UserController());
  final _userRepo = Get.put(UserRepo());

  void signatureId() async {
    var signatureId = await SmsAutoFill().getAppSignature;
    userController.signatureId.value = signatureId;
    print('SignatureId store: ${userController.signatureId.value}');
  }

  final countryCode = '+91';

  final phoneNumberController = TextEditingController();

  var isCheckingPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customBackground,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                            child: Image.asset('assets/images/KodeRx_Logo.png',
                                width: 50.0, height: 50.0),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('KodeRx',
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
                          spacing = 100.0;
                        } else {
                          // Tablet mode or larger
                          spacing = 200.0;
                        }

                        return SizedBox(
                            height:
                                spacing); // Add space below the top elements
                      },
                    ),
                    // Add the login_image here
                    Image.asset('assets/images/ic_home_bg.png',
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  TextSpan(text: 'To Get Started'),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 15.0)),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade500, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: TextField(
                                maxLength: 10,
                                controller: phoneNumberController,
                                keyboardType: TextInputType.number,
                                onSubmitted: (String value) async {
                                  handlePhoneNumberCheck(context);
                                },
                                decoration: const InputDecoration(
                                    prefixText: '+91',
                                    labelStyle: TextStyle(
                                        color: AppColors.customBackground),
                                    labelText: 'Enter your phone number',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10.0),
                                    counterText: ''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (isCheckingPhoneNumber)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.6),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.customBackground,
                        ),
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

  Future<void> handlePhoneNumberCheck(context) async {
    signatureId();
    if (phoneNumberController.text.toString().isNotEmpty) {
      isCheckingPhoneNumber = true;
      // Trigger a rebuild
      Get.forceAppUpdate();

      String enteredPhoneNumber = phoneNumberController.text.toString().trim();
      UserModel? user =
          await _userRepo.getUserDetails('$countryCode$enteredPhoneNumber');

      if (user != null && user.phoneNo == '$countryCode$enteredPhoneNumber') {
        if (user.accountStatus == 'delete') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialog(
                  dialogTitle: 'Contact Administrator',
                  dialogMessage:
                      'Account has been set for deletion, you cannot loggin!',
                  rightButtonText: 'Ok',
                  leftButtonText: 'Cancel',
                  onLeftButtonPressed: () => Navigator.pop(context),
                  onRightButtonPressed: () => Navigator.pop(context),
                );
              });
        } else {
          loginPhoneNumber.value = '$countryCode$enteredPhoneNumber';
          AuthOperation.signIn;
          AuthenticationRepo.instance
              .phoneAuthentication('$countryCode$enteredPhoneNumber');
          Get.to(() => OTPScreen(AuthOperation.signIn));
        }
      } else {
        loginPhoneNumber.value = '$countryCode$enteredPhoneNumber';
        Get.to(() => PrivacyPolicy());
        Get.snackbar(
          'Phone Number Not Registered!',
          'Please Create your account',
          barBlur: 10,
          backgroundColor: Colors.red.withOpacity(0.9),
          icon: Icon(Icons.warning_amber_outlined),
          margin: EdgeInsets.only(top: 20.0),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      }

      isCheckingPhoneNumber = false;
      // Trigger a rebuild
      Get.forceAppUpdate();
    } else {
      Get.snackbar(
        'No Phone Number Added!',
        'Please add your phone number',
        barBlur: 10,
        backgroundColor: Colors.white.withOpacity(0.6),
        icon: Icon(Icons.warning_amber_outlined),
        margin: EdgeInsets.only(top: 20.0),
      );
    }
  }
}
