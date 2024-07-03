// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/upload/short_video/page/short_video_details_page.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/trim_slinder.dart';

class ShortVideoPage extends StatefulWidget {
  final File shortVideoFile;
  const ShortVideoPage({super.key, required this.shortVideoFile});

  @override
  State<ShortVideoPage> createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  late VideoEditorController editorController;
  final isExporting = ValueNotifier<bool>(false);
  final exportingProgress = ValueNotifier<double>(0.0);
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

  Future<void> exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(editorController);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    FFmpegKit.executeAsync(
      command,
      (session) async {
        ///exporting status success or failure
        final ReturnCode? code = await session.getReturnCode();
        if (ReturnCode.isSuccess(code)) {
          ///export the video

          isExporting.value = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShortVideoDetailsPage(
                video: widget.shortVideoFile,
              ),
            ),
          );
        } else {
          ///show some errors
          showErrorSnackBar(
            "Failed, video can't be exported",
            context,
          );
        }
      },
      null,
      (status) {
        ///to visualy see the exporting video progress
        exportingProgress.value =
            config.getFFmpegProgress(status.getTime().toInt());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    editorController.dispose();
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
                        onPressed: exportVideo,
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
