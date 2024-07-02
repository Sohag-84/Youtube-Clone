// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/upload/long%20video/video_repository.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File video;
  const VideoDetailsPage({super.key, required this.video});

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isThumbnailSelected = false;
  File? image;
  String randomNumber = const Uuid().v4();
  String videoId = const Uuid().v4();
  bool isVideoUpload = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///wirte video title & description
                const Text(
                  "Enter the title",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const Gap(5),

                ///title textfield
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter the title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Gap(20),
                const Text(
                  "Enter the description",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const Gap(5),

                ///description textfield
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter the description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Gap(15),

                ///select thumbnail
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      image = await pickImage();
                      if (image != null) {
                        isThumbnailSelected = true;
                      }
                      setState(() {});
                    },
                    child: const Text(
                      "Select Thumbnail",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Gap(10),

                ///show selected thumbnail
                isThumbnailSelected
                    ? Image.file(
                        image!,
                        cacheHeight: 200,
                        cacheWidth: 300,
                      )
                    : const SizedBox(),
                const Gap(10),

                ///published video
                isThumbnailSelected
                    ? isVideoUpload

                        ///show loading when video will be upload
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                debugPrint("Outside of the publish button");
                              },
                              child: const Text(
                                "Loading....",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )

                        ///publish button
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                ///published video
                                setState(() {
                                  isVideoUpload = true;
                                });
                                String thumbnail = await putFileInStorage(
                                  file: image,
                                  number: randomNumber,
                                  fileType: 'image',
                                );
                                String videoUrl = await putFileInStorage(
                                  file: widget.video,
                                  number: randomNumber,
                                  fileType: 'video',
                                );

                                await ref
                                    .watch(longVideoProvider)
                                    .uploadVideoToFirebase(
                                      videoUrl: videoUrl,
                                      thumbnail: thumbnail,
                                      title: titleController.text,
                                      datePublished: DateTime.now(),
                                      videoId: videoId,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                Fluttertoast.showToast(msg: "Video uploaded");
                                Navigator.pop(context);
                                setState(() {
                                  isVideoUpload = false;
                                });
                              },
                              child: const Text(
                                "Publish",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
