import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/features/account/items.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //const Gap(20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                user.profilePic,
              ),
            ),
            Text(
              user.displayName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.username,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(20),
            const Items(),
          ],
        ),
      ),
    );
  }
}
