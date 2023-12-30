import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kode_rx/Components/alert_dialogue.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Controllers/utils.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/otp_screen.dart';
import 'package:kode_rx/data_state_store.dart';
import 'Controllers/authentication_repo.dart';

enum AuthOperation { signUp, signIn }

class Profile extends StatelessWidget {
  Profile({super.key});
  static Profile get instance => Get.find();
  UserController userController = Get.put(UserController());
  final controller = Get.put(ProfileController());
  final userRepository = Get.put(UserRepo());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController =
      TextEditingController(text: loginPhoneNumber.value);
  Uint8List? _profileImage;
  Uint8List? _signature;
  // var profileImageUpdate = '';
  // var signatureImageUpdate = '';
  final specialtyController = TextEditingController();

  void changeProfileImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _profileImage = img;
    Get.find<UserController>().update();
  }

  void changeSignatureImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _signature = img;
    Get.find<UserController>().update();
  }

  Future<void> updateProfileImage(Uint8List img) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage bucket
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('profile_images/$fileName.jpg');

    // Upload the image to Firebase Storage
    await reference.putData(img);

    // Get the download URL for the uploaded image
    String imageUrl = await reference.getDownloadURL();
    userController.userProfileUpdateUrl.value = imageUrl;
  }

  Future<void> updateSignitureUpdate(Uint8List img) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage bucket
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('signature_images/$fileName.jpg');

    // Upload the image to Firebase Storage
    await reference.putData(img);

    // Get the download URL for the uploaded image
    String imageUrl = await reference.getDownloadURL();
    userController.userSignitureUpdateUrl.value = imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Profile'),
      body: Obx(
        () => UserRepo.instance.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.customBackground,
                ),
              )
            : SingleChildScrollView(
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel userData = snapshot.data as UserModel;
                        final username =
                            TextEditingController(text: userData.fullname);
                        final email =
                            TextEditingController(text: userData.email);
                        final phone =
                            TextEditingController(text: userData.phoneNo);
                        final speciality =
                            TextEditingController(text: userData.specialist);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            GetBuilder<UserController>(
                              builder: (_) {
                                return Stack(
                                  children: [
                                    _profileImage != null
                                        ? CircleAvatar(
                                            radius: 64,
                                            backgroundImage:
                                                MemoryImage(_profileImage!),
                                          )
                                        : CircleAvatar(
                                            radius: 64,
                                            backgroundImage: NetworkImage(userData
                                                        .profileImage ==
                                                    ''
                                                ? 'https://cdn-icons-png.flaticon.com/128/8815/8815112.png'
                                                : userData.profileImage),
                                          ),
                                    Positioned(
                                      bottom: -10,
                                      right: -10,
                                      child: IconButton(
                                        icon: const Icon(Icons.add_a_photo),
                                        onPressed: changeProfileImage,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        fontSize: 42,
                                        color: AppColors.customBackground),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomTextfield(
                              controller: username,
                              hintText: 'Enter your full name',
                              obsecureText: false,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextfield(
                              controller: email,
                              hintText: 'Enter your email',
                              obsecureText: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextfield(
                              controller: phone,
                              hintText: 'Enter your phone number',
                              obsecureText: false,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextfield(
                                controller: speciality,
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
                                  const Expanded(
                                      child: Text(
                                    'Add your Signature',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                                  GetBuilder<UserController>(
                                    builder: (_) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                16), // Adjust the radius as needed
                                            child: SizedBox(
                                              width:
                                                  128, // Set the desired width for the square image
                                              height:
                                                  128, // Set the desired height for the square image
                                              child: _signature != null
                                                  ? Image.memory(_signature!,
                                                      fit: BoxFit.contain)
                                                  : userData.signature != ''
                                                      ? Image.network(
                                                          userData.signature,
                                                          width: 50.0,
                                                          height: 50.0,
                                                          fit: BoxFit.contain)
                                                      : Image.asset(
                                                          "assets/images/ic_signature.png",
                                                          width: 50.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.add_a_photo,
                                                color: Colors.white,
                                              ),
                                              onPressed: changeSignatureImage,
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
                              buttonText: 'Update ',
                              onTap: () async {
                                try {
                                  Get.dialog(Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.customBackground)));
                                  if (_profileImage != null) {
                                    await updateProfileImage(_profileImage!);
                                  }

                                  if (_signature != null) {
                                    await updateSignitureUpdate(_signature!);
                                  }
                                  Get.back();

                                  final user = UserModel(
                                      fullname: username.text.trim(),
                                      email: email.text.trim(),
                                      phoneNo: phone.text.trim(),
                                      profileImage: userController
                                                  .userProfileUpdateUrl
                                                  .isEmpty ||
                                              userController
                                                      .userProfileUpdateUrl
                                                      .value ==
                                                  ''

                                          /// userController.userProfileUpdateUrl.value == userData.profileImage
                                          ? userData.profileImage
                                          : userController
                                              .userProfileUpdateUrl.value,
                                      signature: userController
                                                  .userSignitureUpdateUrl
                                                  .isEmpty ||
                                              userController
                                                      .userSignitureUpdateUrl
                                                      .value ==
                                                  ''
                                          ? userData.signature
                                          : userController
                                              .userSignitureUpdateUrl.value,
                                      specialist: speciality.text.trim(),
                                      status: userData.status,
                                      accountStatus: 'active');
                                  await controller.updateRecord(user);
                                  //  HomeScreen.instance.updateDataFromProfileScreen();
                                  // userController.userProfileImageUrl.value = '';
                                  // userController.userSignitureUpdateUrl.value =
                                  //     '';
                                  // Get.back();
                                } catch (e) {
                                  print('Error during update: $e');
                                  // Close loader
                                  // Get.back();
                                }
// Get.back();
                                // Get.put(() => HomeScreen());
                                // await controller.getUserData();
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () => {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      dialogTitle: 'Logout',
                                      dialogMessage:
                                          'Are you sure you want to logout?',
                                      leftButtonText: 'Cancel',
                                      rightButtonText: 'Logout',
                                      onLeftButtonPressed: () =>
                                          Navigator.of(context).pop(),
                                      onRightButtonPressed: logout,
                                    );
                                  },
                                )
                              },
                              child: const Center(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: AppColors.customBackground,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        dialogTitle: 'Deactivation/Deletion',
                                        dialogMessage:
                                            'Deactivation:\nDeactivating your account means a temporary suspension. You can reactivate your account at any time by logging in. Your data will be securely stored during this period.\n\nDeletion:\nDeleting your account is a permanent action that cannot be undone. All associated data will permanently deleted',
                                        leftButtonText: 'Delete',
                                        rightButtonText: 'Deactivate',
                                        onRightButtonPressed: () => {
                                          Navigator.of(context).pop(),
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CustomDialog(
                                                  dialogTitle:
                                                      'Account Deactivation',
                                                  dialogMessage:
                                                      'WARNING: You are about to DEACTIVATE this account',
                                                  leftButtonText: 'Deactivate',
                                                  rightButtonText: 'Cancel',
                                                  onLeftButtonPressed:
                                                      () async => {
                                                    // Get.offAll(context),
                                                    Navigator.of(context).pop(),
                                                    print(
                                                        'Account Deactivated'),
                                                    userRepository
                                                        .disableAccount(
                                                            'deactivate'),
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2)),
                                                    AuthenticationRepo.instance
                                                        .logout(),
                                                  },
                                                  onRightButtonPressed: () =>
                                                      Navigator.pop(context),
                                                );
                                              })
                                        },
                                        onLeftButtonPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CustomDialog(
                                                  dialogTitle:
                                                      'Account Deletion ⚠',
                                                  dialogMessage:
                                                      'WARNING: By Deleting your account, all of the data will be deleted',
                                                  leftButtonText: 'Delete',
                                                  rightButtonText: 'Cancel',
                                                  onRightButtonPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  onLeftButtonPressed:
                                                      () async => {
                                                    Navigator.of(context).pop(),
                                                    print(
                                                        'Your Account has will be completely deleted in 10 Days'),
                                                    userRepository
                                                        .disableAccount(
                                                            'delete'),
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2)),
                                                    AuthenticationRepo.instance
                                                        .logout(),
                                                  },
                                                );
                                              });
                                        },
                                      );
                                    })
                              },
                              child: const Center(
                                  child: Text(
                                'Deactivate or Delete Account',
                                style: TextStyle(color: Colors.redAccent),
                              )),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text('SomeThing went wrong'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.customBackground,
                        ),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}

void logout() {
  AuthenticationRepo.instance.logout();
  Get.snackbar('Logged Out!', 'You are are now logged out');
}

// class LogoutDialog extends StatelessWidget {
//   const LogoutDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//       title: const Text(
//         'Logout',
//       ),
//       content: const Text('Are you sure you want to logout?'),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Perform the action when the "Return" button is pressed
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: const Text(
//             'Cancel',
//             style: TextStyle(color: AppColors.customBackground),
//           ),
//         ),
//         TextButton(
//           style:
//               TextButton.styleFrom(backgroundColor: AppColors.customBackground),
//           onPressed: () {
//             AuthenticationRepo.instance.logout();
//             Get.snackbar('Logged Out!', 'Your are now logged out');

//             // Navigator.of(context).pop(); // Close the dialog
//           },
//           child: const Text(
//             'Logout',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }
