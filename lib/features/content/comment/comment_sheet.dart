import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/comment/comment_tile.dart';
import 'package:youtube_clone/features/upload/comment/comment_model.dart';
import 'package:youtube_clone/features/upload/comment/comment_repository.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;
  const CommentSheet({super.key, required this.video});

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDataProvider).whenData((user) => user);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Comments",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          color: Colors.grey.shade400,
          child: const Text(
            "Remember to keep comments respectful and to follow our community and guideline",
          ),
        ),
        const Gap(10),

        ///fetched comment list
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .where('videoId', isEqualTo: widget.video.videoId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader();
              } else {
                final commentMap = snapshot.data!.docs;
                final comment = commentMap
                    .map((comment) => CommentModel.fromMap(comment.data()))
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comment.length,
                  itemBuilder: (context, index) {
                    return CommentTile(
                      profilePic: comment[index].profilePic,
                      displayName: comment[index].displayName,
                      commentText: comment[index].commentText,
                    );
                  },
                );
              }
            },
          ),
        ),

        //const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 12),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 5),
              SizedBox(
                height: 45,
                width: 240,
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: "Add a comment",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              ///send comment
              IconButton(
                onPressed: () async {
                  if (commentController.text.trim().isNotEmpty) {
                    await ref
                        .watch(commentRepositoryProvider)
                        .uploadCommentToFirestore(
                          commentText: commentController.text,
                          videoId: widget.video.videoId,
                          displayName: user.value!.displayName,
                          profilePic: user.value!.profilePic,
                        );
                  }
                  commentController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  size: 35,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
