import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 4.0,
          ),
          child: Text(
            "IH Sohag",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.blueGrey),
              children: [
                TextSpan(text: "ihsohag  "),
                TextSpan(text: "No subscriptions  "),
                TextSpan(text: "No videos"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
