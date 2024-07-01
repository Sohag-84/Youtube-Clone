import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/methods.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isThumbnailSelected = false;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {},
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
    );
  }
}
