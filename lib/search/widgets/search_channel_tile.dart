import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

class SearchChannelTile extends StatelessWidget {
  final UserModel user;
  const SearchChannelTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10,
        right: 10,
        bottom: 20,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(
              user.profilePic,
            ),
          ),
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
                    onPressed: () {},
                    colour: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
