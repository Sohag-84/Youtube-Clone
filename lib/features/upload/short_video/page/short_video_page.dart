import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/trim_slinder.dart';

class ShortVideoPage extends StatefulWidget {
  final File shortVideoFile;
  const ShortVideoPage({super.key, required this.shortVideoFile});

  @override
  State<ShortVideoPage> createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  late VideoEditorController editorController;
  @override
  void initState() {
    super.initState();
    editorController = VideoEditorController.file(
      widget.shortVideoFile,
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(seconds: 60),
    );
    editorController.initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: editorController.initialized
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 200,
                    child: CropGridViewer.preview(
                      controller: editorController,
                    ),
                  ),
                  const Spacer(),
                  MyTrimSlider(
                    controller: editorController,
                    height: 45,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("DONE"),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
