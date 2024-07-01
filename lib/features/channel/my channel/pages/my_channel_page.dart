import 'package:flutter/material.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/buttons.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/tab_bar.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/tab_pages.dart';
import 'package:youtube_clone/features/channel/my%20channel/parts/top_header.dart';

class MyChannelPage extends StatelessWidget {
  const MyChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 7,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                ///top header
                TopHeader(),
                Text("More about this channel"),

                ///buttons
                Buttons(),

                ///create tabbar
                PageTabbar(),
                TabPages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
