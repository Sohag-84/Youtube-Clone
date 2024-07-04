import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

final allChannelProvider = Provider((ref) async {
  final userMap = await FirebaseFirestore.instance.collection('users').get();

  List<UserModel> users =
      userMap.docs.map((user) => UserModel.fromMap(user.data())).toList();

  return users;
});
final allVideoProvider = Provider((ref) async {
  final videoMap = await FirebaseFirestore.instance.collection('videos').get();

  List<VideoModel> videos =
      videoMap.docs.map((video) => VideoModel.fromMap(video.data())).toList();

  return videos;
});
