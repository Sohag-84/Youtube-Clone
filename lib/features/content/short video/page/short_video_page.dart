import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/content/short%20video/parts/short_video_tile.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';

class ShortVideoPage extends StatelessWidget {
  const ShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('shorts').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loader();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final shortVideoMap = snapshot.data!.docs;
                  final shortVideo = ShortVideoModel.fromMap(
                    shortVideoMap[index].data(),
                  );

                  return ShortVideoTile(shortVideo: shortVideo);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
