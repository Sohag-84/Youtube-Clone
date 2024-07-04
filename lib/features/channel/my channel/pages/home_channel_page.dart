import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/channel/provider/channel_provider.dart';
import 'package:youtube_clone/features/content/long_video/parts/post.dart';

class HomeChannelPage extends StatelessWidget {
  const HomeChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(eacheChannelVideosProvider(
                  FirebaseAuth.instance.currentUser!.uid))
              .when(
                data: (video) => Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  child: video.isEmpty
                      ? const Center(
                          child: Text(
                            "No Video uploaded",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : GridView.builder(
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
    );
  }
}
