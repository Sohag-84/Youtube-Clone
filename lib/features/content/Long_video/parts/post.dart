import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/long_video/parts/video.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvider(video.userId));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Video(video: video),
          ),
        );
      },
      child: Column(
        children: [
          /// thumbnail image
          CachedNetworkImage(
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: video.thumbnail,
            placeholder: (context, url) => const Loader(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          /// profile image, video title & delete video
          userModel.when(
            data: (user) => Row(
              children: [
                /// profile image
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(user.profilePic),
                  ),
                ),
                const Gap(3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${user.displayName}  ${video.views == 0 ? "No views" : video.views}  ${timeago.format(video.datePublished)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
            loading: () => const Loader(),
            error: (err, stack) => const ErrorPage(),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}
