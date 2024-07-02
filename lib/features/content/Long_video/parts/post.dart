import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

class Post extends StatelessWidget {
  final VideoModel video;
  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///thumbnail image
        CachedNetworkImage(
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: video.thumbnail,
          placeholder: (context, url) => const Loader(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),

        ///profile image, video title & delete video
        Row(
          children: [
            ///profile image
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text(
                        "IH Sohag",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        "${video.views} views",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const Gap(8),
                      const Text(
                        "a moment ago",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        const Gap(15),
      ],
    );
  }
}
