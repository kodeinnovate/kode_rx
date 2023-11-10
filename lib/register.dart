import 'package:flutter/material.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/device_helper.dart';

class Signup extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Having trouble signing up?', style: TextStyle(fontSize: 16, color: Colors.grey.shade600),),
                      const SizedBox(width: 4,),
                      Text('Contact Us', style: TextStyle(color: AppColors.customBackground, fontSize: 16),),
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
  }
}
