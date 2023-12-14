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

class Profile extends StatelessWidget {
  Profile({super.key});
  static Profile get instance => Get.find();
  UserController userController = Get.put(UserController());
  final userRepository = Get.put(UserRepo());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController =
  TextEditingController(text: loginPhoneNumber.value);
  Uint8List? _profileImage;
  final specialtyController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    // Set the image URL in your model
    _profileImage = img;
    // Generate a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage bucket
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('profile_images/$fileName.jpg');

    // Upload the image to Firebase Storage
    await reference.putData(img);

    // Get the download URL for the uploaded image
    String imageUrl = await reference.getDownloadURL();

    userController.userProfileImageUrl.value = imageUrl;
    Get.find<UserController>().update();
    // Get.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        _profileImage != null
                            ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_profileImage!),
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
                        "Profile",
                        style: TextStyle(
                            fontSize: 42, color: AppColors.customBackground),
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
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obsecureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: phoneNumberController,
                  hintText: 'Enter your phone number',
                  obsecureText: false,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    controller: specialtyController,
                    hintText: 'Speciality',
                    obsecureText: false,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    children: [
                      Expanded(child:const Text('Add your Signature',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
            GetBuilder<UserController>(
              builder: (_) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                      child: Container(
                        width: 128, // Set the desired width for the square image
                        height: 128, // Set the desired height for the square image
                        child: _profileImage != null
                            ? Image.memory(_profileImage!, fit: BoxFit.cover)
                            : Image(
                image: AssetImage("assets/images/ic_signature.png"),
                width:  50.0 ,
                height:  50.0,
                ),
                        ),
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
            )

            ],
                  ),
                ),
                CustomButtom(
                  buttonText: 'Update',
                  onTap: updateUser,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: AppColors.customBackground, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

//Authentication Function, the data
  updateUser() {
    //
  }

  Future<void> dataStore(UserModel user) async {
    await userRepository.createUser(user);
  }

}