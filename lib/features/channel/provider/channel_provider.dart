import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

final eacheChannelVideosProvider = FutureProvider.family((ref, userId) async {
  final videosMap = await FirebaseFirestore.instance
      .collection('videos')
      .where("userId", isEqualTo: userId)
      .get();

  List<VideoModel> videos =
      videosMap.docs.map((video) => VideoModel.fromMap(video.data())).toList();

  return videos;
});
