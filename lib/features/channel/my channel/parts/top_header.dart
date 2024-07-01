import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(
              user.profilePic,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 4.0,
          ),
          child: Text(
            user.displayName,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.blueGrey),
              children: [
                TextSpan(text: "${user.username}  "),
                TextSpan(text: "${user.subscriptions.length} subscriptions  "),
                TextSpan(text: "${user.videos} videos"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
