import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/channel/user%20channel/page/user_channel_page.dart';

import '../../features/channel/user channel/repository/subscribe_repository.dart';

class SearchChannelTile extends ConsumerWidget {
  final UserModel user;
  const SearchChannelTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10,
        right: 10,
        bottom: 20,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserChannelPage(userId: user.userId),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                user.profilePic,
              ),
            ),
            const Gap(5),
            Expanded(
              child: Column(
                children: [
                  ///display name
                  Text(
                    user.displayName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  ///username
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),

                  ///subscriptions
                  Text(
                    user.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  const Gap(2),

                  ///subscribe button
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: FlatButton(
                      text: "SUBSCRIBE",
                      onPressed: () async {
                        await ref
                            .watch(subscribeChannelProvider)
                            .subscribeChannel(
                              userId: user.userId,
                              currentUserId:
                                  FirebaseAuth.instance.currentUser!.uid,
                              subscriptions: user.subscriptions,
                            );
                      },
                      colour: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
