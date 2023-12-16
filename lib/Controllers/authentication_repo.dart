import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/database_fetch.dart';
import 'package:kode_rx/Controllers/profile_controller.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/login.dart';
import 'package:kode_rx/register.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();
  UserController userController = Get.put(UserController());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() async {
    //  await Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (user) => _setInitialScreen(user));
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => LoginScreen());
      print('User logged out');
    } else {
      String phoneNumber = user.phoneNumber!;
      UserModel? userDetails =
          await UserRepo.instance.getUserDetails(phoneNumber);
      if (userDetails != null) {
        String userId = userDetails.id!;
        userController.userId.value = userId;
        // Navigate to the HomeScreen and pass the userId as an argument
        Get.offAll(() => HomeScreen());
      } else {
        print('User details not found in Firestore');
      }
      Get.offAll(() => HomeScreen());
      print('Logged In');
    }
  }

  Future<void> phoneAuthentication(String number) async {
    try {
      // firebaseUser.value == null ? Get.offAll(() => Signup()) : Get.offAll(() => HomeScreen());
      await _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: (credential) async {
            await _auth.signInWithCredential(credential);
          },
          codeSent: (verificationId, resendToken) {
            this.verificationId.value = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId) {
            this.verificationId.value = verificationId;
          },
          verificationFailed: (e) {
            if (e.code == 'invalid-phone-number') {
              Get.snackbar('Error', 'The provided phone number is not valid.');
            } else {
              Get.snackbar('Error', 'Something went wrong. Try again.');
            }
          },
          timeout: const Duration(seconds: 120));
    } catch (e) {
      print('Error during phone authentication: $e');
      Get.snackbar('Error', 'Something went wrong. Try again.');
    }
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }
}
