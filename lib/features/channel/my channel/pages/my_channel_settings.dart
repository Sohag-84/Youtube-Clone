import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/features/channel/my%20channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/flutter background.png",
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 170,
                  top: 60,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 10,
                  child: Image.asset(
                    'assets/icons/camera.png',
                    height: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            ///second part
            const Gap(10),
            SettingsItem(
              identifier: "Name",
              onPressed: () {},
              value: "IH Sohag",
            ),
            const Gap(10),
            SettingsItem(
              identifier: "Handle",
              onPressed: () {},
              value: "@ih-sohag",
            ),
            const Gap(10),
            SettingsItem(
              identifier: "Description",
              onPressed: () {},
              value: "",
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Keep all my subscribers private"),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const Gap(15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Changes mode on your names and profile pictures are more visible only to Youtbe and not other google services",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
