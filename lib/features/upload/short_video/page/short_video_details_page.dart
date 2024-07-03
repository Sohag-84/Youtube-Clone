import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/upload/short_video/repository/short_video_repository.dart';
import 'package:youtube_clone/home_page.dart';

class ShortVideoDetailsPage extends ConsumerStatefulWidget {
  final File video;
  const ShortVideoDetailsPage({super.key, required this.video});

  @override
  ConsumerState<ShortVideoDetailsPage> createState() =>
      _ShortVideoDetailsPageState();
}

class _ShortVideoDetailsPageState extends ConsumerState<ShortVideoDetailsPage> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();
  bool isShortVideoUpload = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          "Video Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: captionController,
              decoration: InputDecoration(
                hintText: "Write a caption",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),
            isShortVideoUpload
                ? FlatButton(
                    text: "LOADING.....",
                    onPressed: () {},
                    colour: Colors.green,
                  )
                : FlatButton(
                    text: "PUBLISH",
                    onPressed: () async {
                      setState(() {
                        isShortVideoUpload = true;
                      });
                      if (captionController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Caption can't be empty");
                      } else {
                        await ref
                            .watch(shortVideoRepositoryProvider)
                            .uploadShortVideoToFirestore(
                              caption: captionController.text,
                              video: widget.video.path,
                              datePublished: date,
                            );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                      setState(() {
                        isShortVideoUpload = false;
                      });
                    },
                    colour: Colors.green,
                  ),
          ],
        ),
      ),
    );
  }
}
