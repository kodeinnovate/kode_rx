import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class SendSms extends GetxController {
  static SendSms get instance => Get.find();

  late final TwilioFlutter twilioFlutter;

  SendSms() {
    twilioFlutter = TwilioFlutter(
      accountSid: 'ACc80b04de28ae921582bd6333d5ecc857',
      authToken: '1ab21c9b7b1f403909c291f428695d99',
      twilioNumber: '+16092077250',
    );
  }

  void sendSms(String number, String name, String followUpDate) async {
    twilioFlutter.sendSMS(toNumber: '+91$number', messageBody: 'Thank you $name for visiting our clinic ${followUpDate.isEmpty ? '' : ', your follow-up date is $followUpDate'}');
  }
}
