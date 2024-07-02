import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/buttons.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/tab_bar.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/tab_pages.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/top_header.dart';

class MyChannelPage extends ConsumerWidget {
  const MyChannelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserDataProvider).when(
          data: (currentUser) {
            return DefaultTabController(
              length: 7,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        ///top header
                        TopHeader(
                          user: currentUser,
                        ),
                        const Text("More about this channel"),

                        ///buttons
                        const Buttons(),

                        ///create tabbar
                        const PageTabbar(),
                        const TabPages(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
