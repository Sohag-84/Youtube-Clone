import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/features/upload/comment/comment_model.dart';

final commentRepositoryProvider = Provider(
  (ref) => CommentRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class CommentRepository {
  FirebaseFirestore firestore;

  CommentRepository({required this.firestore});

  Future<void> uploadCommentToFirestore({
    required String commentText,
    required String videoId,
    required String displayName,
    required String profilePic,
  }) async {
    String commentId = const Uuid().v4();
    CommentModel commentModel = CommentModel(
      commentText: commentText,
      videoId: videoId,
      commentId: commentId,
      displayName: displayName,
      profilePic: profilePic,
    );

    firestore.collection('comments').doc(commentId).set(commentModel.toMap());
  }
}
