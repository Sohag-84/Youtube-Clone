import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommentTile extends StatelessWidget {
  final String commentText;
  final String profilePic;
  final String displayName;

  const CommentTile({
    super.key,
    required this.commentText,
    required this.profilePic,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(profilePic),
          ),
          const Gap(5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///display name, time ago, delete comment button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(10),
                    const Text("a moment ago"),
                    const Spacer(),
                    const Icon(Icons.more_vert),
                  ],
                ),
                Text(commentText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
