// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/features/upload/long%20video/video_details_page.dart';
import 'package:youtube_clone/features/upload/short_video/page/short_video_export_page.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

///for pick video
Future pickVideo({required BuildContext context}) async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
  );
  if (file != null) {
    File videoPath = File(file.path);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoDetailsPage(
          video: videoPath,
        ),
      ),
    );
  }
}

///for pick video
Future pickShortVideo({required BuildContext context}) async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
  );
  if (file != null) {
    File videoPath = File(file.path);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShortVideoExportPage(
          shortVideoFile: videoPath,
        ),
      ),
    );
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
  } else {
    return null;
  }
}

//for store file in firebase storage
Future<String> putFileInStorage({
  required file,
  required number,
  required fileType,
}) async {
  final ref = FirebaseStorage.instance.ref().child("$fileType/$number");
  final upload = ref.putFile(file);
  final snapshot = await upload;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
