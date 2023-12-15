import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Controllers/utils.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/otp_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'Controllers/authentication_repo.dart';

enum AuthOperation { signUp, signIn }

class Signup extends StatelessWidget {
  Signup({super.key});
  static Signup get instance => Get.find();
  UserController userController = Get.put(UserController());
  final userRepository = Get.put(UserRepo());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController =
      TextEditingController(text: loginPhoneNumber.value);
  Uint8List? profileImage;
  final specialtyController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    // Set the image URL in your model
    profileImage = img;
    userController.profileImage.value = img;
    Get.find<UserController>().update();
    // Generate a unique filename for the image
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // // Reference to the Firebase Storage bucket
    // firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance
    //     .ref('profile_images/$fileName.jpg');

    // // Upload the image to Firebase Storage
    // await reference.putData(img);

    // // Get the download URL for the uploaded image
    // String imageUrl = await reference.getDownloadURL();

    // userController.userProfileImageUrl.value = imageUrl;
    // Get.update();
    // uploadImage(img);
  }

  Future<void> uploadImage(Uint8List img) async {
   String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage bucket
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance
        .ref('profile_images/$fileName.jpg');

    // Upload the image to Firebase Storage
    await reference.putData(img);

    // Get the download URL for the uploaded image
    String imageUrl = await reference.getDownloadURL();
    userController.userProfileImageUrl.value = imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // const Icon(
                  //   Icons.cloud_outlined,
                  //   size: 100,
                  //   color: AppColors.customBackground,
                  // ),
                  
                  GetBuilder<UserController>(
                    builder: (_) {
                      return Stack(
                        children: [
                          profileImage != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(profileImage!),
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/128/8815/8815112.png'),
                                ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                              icon: const Icon(Icons.add_a_photo),
                              onPressed: selectImage,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
        
                  // Stack(
                  //   children: [
                  //     _profileImage != null ? CircleAvatar(
                  //       radius: 64,
                  //       backgroundImage: MemoryImage(
                  //           _profileImage!),
                  //     ) :
                  //     const CircleAvatar(
                  //       radius: 64,
                  //       backgroundImage: NetworkImage(
                  //           'https://cdn-icons-png.flaticon.com/512/1053/1053244.png'),
                  //     ),
                  //     Positioned(
                  //       bottom: -10,
                  //       right: -10,
                  //       child: IconButton(
                  //         icon: const Icon(Icons.add_a_photo),
                  //         onPressed: selectImage,
                  //       ),
                  //     )
                  //   ],
                  // ),
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
                    obsecureText: false, keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: emailController,
                    hintText: 'Enter your email',
                    obsecureText: false, keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: phoneNumberController,
                    hintText: 'Enter your phone number',
                    obsecureText: false, keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(controller: specialtyController, hintText: 'Speciality', obsecureText: false, keyboardType: TextInputType.text),
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
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey.shade600),
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

//Authentication Function, the data
  signUserUp() {
    userController.userName.value = usernameController.text.toString().trim();
    userController.userEmail.value = emailController.text.toString().trim();
    userController.userPhoneNumber.value =
        phoneNumberController.text.toString().trim();
        userController.userSpecialty.value = specialtyController.text.toString().trim();

    if (usernameController.text.toString().isNotEmpty &&
        emailController.text.toString().isNotEmpty &&
        phoneNumberController.text.toString().isNotEmpty && specialtyController.text.toString().isNotEmpty) {
      AuthOperation.signUp;
      AuthenticationRepo.instance
          .phoneAuthentication(phoneNumberController.text.toString());
          if(userController.profileImage.value == null){

          }
          else{
          uploadImage(userController.profileImage.value!);
          }
      Get.to(() => OTPScreen(AuthOperation.signUp));
    } else {
      Get.snackbar('Field Empty!', 'Please fill all the inputs',
          barBlur: 10,
          backgroundColor: Colors.white.withOpacity(0.6),
          icon: const Icon(Icons.warning_amber_outlined),
          margin: const EdgeInsets.only(top: 20.0));
    }
  }

  Future<void> dataStore(UserModel user) async {
    await userRepository.createUser(user);
  }

  void otpOnSubmit(String otp, AuthOperation authOperation) async {
       
    final user = UserModel(
        fullname: userController.userName.value,
        email: userController.userEmail.value,
        phoneNo: userController.userPhoneNumber.value,
        profileImage: userController.userProfileImageUrl.value,
        specialist: userController.userSpecialty.value,
        signature: '');
    var isVerified = await AuthenticationRepo.instance.verifyOTP(otp);
    if (isVerified) {
      if (authOperation == AuthOperation.signUp) {
        Get.to(() => HomeScreen());
        print(userController.profileImage.value);
        // await Future.delayed(const Duration(seconds: 2));
       dataStore(user);
      } else if (authOperation == AuthOperation.signIn) {
        Get.to(() => HomeScreen());
        Get.snackbar('SIGNED IN', 'You have Successfull signed in!',
            icon: const Icon(Icons.check_circle));
      }
    } else {
      Get.to(() => Signup());
    }
  }
}
