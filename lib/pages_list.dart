import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content/long_video/long_video_page.dart';

import 'features/content/short video/page/short_video_page.dart';

List<Widget> pages = const [
 LongVideoPage(),
  ShortVideoPage(),
  Center(child: Text("Upload")),
  Center(child: Text("Search")),
  Center(child: Text("Home")),
];
