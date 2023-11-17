import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/otp_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'Controllers/authentication_repo.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  static Signup get instance => Get.find();
  UserController userController = Get.put(UserController());
  final userRepository = Get.put(UserRepo());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

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
     userController.userName.value = usernameController.text.toString().trim();
    userController.userEmail.value = emailController.text.toString().trim();
    userController.userPhoneNumber.value = phoneNumberController.text.toString().trim();

    // userName = userName;
    // userEmail = userEmail;
    // userPhoneNumber = userPhoneNumber;
    // Constant(email: userEmail, name: userName, phoneNumber: userPhoneNumber);
    // data(usernameController.text.toString(), emailController.text.toString(),
    //     phoneNumberController.text.toString());
    // phoneAuthentication(phoneNumberController.text.toString());
    // AuthenticationRepo(fullname: usernameController.text.trim(), email: emailController.text.trim(), phoneNo: phoneNumberController.text.toString().trim());
    // dataStore(user);
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
    final user = UserModel(
      fullname: userController.userName.value,
      email: userController.userEmail.value,
      phoneNo: userController.userPhoneNumber.value,
    );
    print('function is working');
    // var isVerified = await verifyOTP(otp);
    var isVerified = await AuthenticationRepo.instance.verifyOTP(otp);
    print('working further');
    if (isVerified) {
      Get.to(() => HomeScreen());
      dataStore(user);
    } else {
      Get.to(() => Signup());
    }
    // isVerified ? Get.to(HomeScreen()) : Get.to(Signup());
  }
}
