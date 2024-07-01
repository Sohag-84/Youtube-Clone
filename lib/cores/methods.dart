import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

///for pick video
pickVideo() async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
  );
  if (file != null) {
    File videoPath = File(file.path);
    return videoPath;
  }
}
