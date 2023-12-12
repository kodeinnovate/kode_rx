import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? image  = await picker.pickImage(source: source);
  if (image  != null) {
    return await image.readAsBytes();
  } else {
    print('Image not selected');
  }
  print('running');
}
