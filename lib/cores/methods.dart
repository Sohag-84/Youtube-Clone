import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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

///for pick image
Future<File?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (file != null) {
    File imagePath = File(file.path);
    return imagePath;
  }else{
    return null;
  }
}

//for store file in firebase storage
putFileInStorage(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child("$fileType/$number");
  final upload = ref.putFile(file);
  final snapshot = await upload;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
