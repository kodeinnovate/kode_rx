import 'package:get/get.dart';

class UserController extends GetxController {
  final RxString verificationID = RxString('');
  final RxString userName = RxString('');
  final RxString userEmail = RxString('');
  final RxString userPhoneNumber = RxString('');
  final RxString doctorsNote = RxString('');
  final RxString userProfileImageUrl = RxString('');
}

final RxString loginPhoneNumber = RxString('');
