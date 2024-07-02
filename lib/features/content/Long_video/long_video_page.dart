import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/content/Long_video/parts/post.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

class LongVideoPage extends StatelessWidget {
  const LongVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loader();
          } else {
            final videoMaps = snapshot.data!.docs;
            final video = videoMaps
                .map((video) => VideoModel.fromMap(video.data()))
                .toList();
            return ListView.builder(
              itemCount: video.length,
              itemBuilder: (context, index) {
                return Post(video: video[index]);
              },
            );
          }
        },
      ),
    );
  }
}
