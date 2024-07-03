import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';

final shortVideoRepositoryProvider = Provider(
  (ref) => ShortVideoRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ShortVideoRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> uploadShortVideoToFirestore({
    required String caption,
    required String video,
    required DateTime datePublished,
  }) async {
    ShortVideoModel shortVideo = ShortVideoModel(
      caption: caption,
      userId: auth.currentUser!.uid,
      shortVideo: video,
      datePublished: datePublished,
    );

    await firestore.collection('shorts').add(shortVideo.toMap());
  }
}
