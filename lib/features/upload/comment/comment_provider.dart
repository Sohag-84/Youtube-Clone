import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/comment/comment_model.dart';

final commentProvider = FutureProvider.family((ref, vedioId) async {
  final commentMap = await FirebaseFirestore.instance
      .collection('comments')
      .where('videoId', isEqualTo: vedioId)
      .get();

  List<CommentModel> commentList = commentMap.docs
      .map((comment) => CommentModel.fromMap(comment.data()))
      .toList();

  return commentList;
});
