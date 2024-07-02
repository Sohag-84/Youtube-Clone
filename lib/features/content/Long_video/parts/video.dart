import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/content/Long_video/widgets/video_externel_buttons.dart';
import 'package:youtube_clone/features/upload/long%20video/video_model.dart';

class Video extends StatefulWidget {
  final VideoModel video;
  const Video({Key? key, required this.video}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

  bool isShowIcons = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  toggleVideoPlayer() async {
    if (_controller.value.isPlaying) {
      ///pause the video
      await _controller.pause();
      isPlaying = false;
      setState(() {});
    } else {
      ///play the video
      await _controller.play();
      isPlaying = true;
      setState(() {});
    }
  }

  goBackward() {
    Duration position = _controller.value.position;
    position = position - const Duration(seconds: 2);
    _controller.seekTo(position);
  }

  goForward() {
    Duration position = _controller.value.position;
    position = position + const Duration(seconds: 2);
    _controller.seekTo(position);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: _controller.value.isInitialized
              ? SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: isShowIcons
                        ? () {
                            isShowIcons = false;
                            setState(() {});
                          }
                        : () {
                            isShowIcons = true;
                            setState(() {});
                          },
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),

                        ///video play icon
                        isShowIcons
                            ? Positioned(
                                left: 150,
                                top: 80,
                                right: 150,
                                bottom: 80,
                                child: GestureDetector(
                                  onTap: toggleVideoPlayer,
                                  child: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/${isPlaying ? "pause" : "play"}.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        ///video go back icon
                        isShowIcons
                            ? Positioned(
                                left: 40,
                                top: 80,
                                bottom: 80,
                                child: GestureDetector(
                                  onTap: goBackward,
                                  child: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/go_back_final.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        ///video go ahead icon
                        isShowIcons
                            ? Positioned(
                                right: 40,
                                top: 80,
                                bottom: 80,
                                child: GestureDetector(
                                  onTap: goForward,
                                  child: SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/go ahead final.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 7.5,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.red,
                                bufferedColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 176,
                  child: Loader(),
                ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            /// Video title
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 4),
              child: Text(
                widget.video.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            /// View & time count
            Padding(
              padding: const EdgeInsets.only(left: 7, top: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 8),
                    child: Text(
                      widget.video.views == 0
                          ? "No view"
                          : "${widget.video.views} views",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, right: 8),
                    child: Text(
                      "5 minutes ago",
                      style: TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 9,
                right: 9,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Injamul Haq Sohag",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "1 Subscriptions",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 35,
                    width: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FlatButton(
                        text: "Subscribe",
                        onPressed: () {},
                        colour: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: softBlueGreyBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.thumb_up,
                              size: 15.5,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.thumb_down,
                            size: 15.5,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Share",
                        iconData: Icons.share,
                      ),
                    ),
                    const VideoExtraButton(
                      text: "Remix",
                      iconData: Icons.analytics_outlined,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Download",
                        iconData: Icons.download,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
