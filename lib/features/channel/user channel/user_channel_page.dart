import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool haveVideos = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Injamul haq sohag",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "@raiyan",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(text: "NO Subscriptions "),
                            TextSpan(text: "NO Videos"),
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

            haveVideos
                ? const SizedBox()
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.2,
                      ),
                      child: const Text(
                        "No video",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
