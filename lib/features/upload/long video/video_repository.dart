import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

final longVideoProvider = Provider(
  (ref) => VideoRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class VideoRepository {
  FirebaseFirestore firestore;

  VideoRepository({required this.firestore});

  uploadVideoToFirebase({
    required String videoUrl,
    required String thumbnail,
    required String title,
    required DateTime datePublished,
    required String videoId,
    required String userId,
  }) async {
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      title: title,
      datePublished: datePublished,
      views: 0,
      videoId: videoId,
      userId: userId,
      likes: [],
      type: "video",
    );

    await firestore.collection('videos').doc(videoId).set(video.toMap());

    ///update video count
    await firestore.collection('users').doc(userId).update({
      "videos": FieldValue.increment(1),
    });
  }

  Future<void> likeVideo({
    required List? likes,
    required String videoId,
    required String currentUserId,
  }) async {
    if (!likes!.contains(currentUserId)) {
      FirebaseFirestore.instance.collection('videos').doc(videoId).update({
        "likes": FieldValue.arrayUnion([currentUserId]),
      });
    }
    if (likes.contains(currentUserId)) {
      FirebaseFirestore.instance.collection('videos').doc(videoId).update({
        "likes": FieldValue.arrayRemove([currentUserId]),
      });
    }
  }
}
