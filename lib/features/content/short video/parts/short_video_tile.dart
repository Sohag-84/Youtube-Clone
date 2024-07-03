import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShortVideoTile extends StatefulWidget {
  final ShortVideoModel shortVideo;
  const ShortVideoTile({super.key, required this.shortVideo});

  @override
  State<ShortVideoTile> createState() => _ShortVideoTileState();
}

class _ShortVideoTileState extends State<ShortVideoTile> {
  late VideoPlayerController shortVideoController;

  @override
  void initState() {
    super.initState();
    shortVideoController = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.shortVideo.shortVideo,
      ),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    shortVideoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: shortVideoController.value.isInitialized
          ? Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (shortVideoController.value.isPlaying) {
                      shortVideoController.pause();
                    } else {
                      shortVideoController.play();
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 11 / 16,
                    child: VideoPlayer(shortVideoController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shortVideo.caption +
                              widget.shortVideo.caption +
                              widget.shortVideo.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        timeago.format(
                          widget.shortVideo.datePublished,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
