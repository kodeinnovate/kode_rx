import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kode_rx/home.dart';
import 'package:kode_rx/register.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => Signup()) : Get.offAll(() => HomeScreen());
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
            // print('Verification ID set: $verificationId');
            // print(verificationID.value);
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
