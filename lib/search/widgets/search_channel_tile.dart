import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class SearchChannelTile extends StatelessWidget {
  const SearchChannelTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey,
          ),
          const Gap(40),
          Column(
            children: [
              ///display name
              const Text(
                "IH Sohag",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),

              ///username
              const Text(
                "@sohag",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
              ),

              ///subscriptions
              const Text(
                "No Subscriptions",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              const Gap(2),

              ///subscribe button
              SizedBox(
                height: 40,
                width: 110,
                child: FlatButton(
                  text: "SUBSCRIBE",
                  onPressed: () {},
                  colour: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
