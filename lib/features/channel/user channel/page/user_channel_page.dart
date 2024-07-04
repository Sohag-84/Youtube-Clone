import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/channel/user%20channel/provider/channel_provider.dart';
import 'package:youtube_clone/features/content/long_video/parts/post.dart';

class UserChannelPage extends StatefulWidget {
  final String userId;
  const UserChannelPage({super.key, required this.userId});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool haveVideos = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///for channel header
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(anyUserDataProvider(widget.userId)).when(
                        data: (data) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ///background image
                            Image.asset(
                              "assets/images/flutter background.png",
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const Gap(10),

                            ///channel info
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(
                                        data.profilePic),
                                  ),
                                  const Gap(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.displayName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data.username,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: data.subscriptions.isEmpty
                                                  ? "NO Subscriptions "
                                                  : "${data.subscriptions.length} Subscriptions",
                                            ),
                                            TextSpan(
                                              text: data.videos == 0
                                                  ? "NO Videos"
                                                  : "${data.videos} Videos",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            ///subscribe button
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20,
                                right: 10,
                              ),
                              child: FlatButton(
                                text: "SUBSCRIBE",
                                onPressed: () {},
                                colour: Colors.black,
                              ),
                            ),

                            data.videos == 0
                                ? const SizedBox()
                                : Text(
                                    "${data.displayName}'s videos",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const Loader(),
                      );
                },
              ),

              ///for show video list
              Consumer(
                builder: (context, ref, child) {
                  return ref
                      .watch(eacheChannelVideosProvider(widget.userId))
                      .when(
                        data: (video) => Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: video.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 320,
                            ),
                            itemBuilder: (context, index) {
                              if (video.isNotEmpty) {
                                return Post(video: video[index]);
                              } else {
                                return const Center(
                                  child: Text(
                                    "No video",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const Loader(),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
