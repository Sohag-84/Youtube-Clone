import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/channel/my%20channel/repository/edit_field.dart';
import 'package:youtube_clone/features/channel/my%20channel/widgets/edit_setting_dialog.dart';
import 'package:youtube_clone/features/channel/my%20channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;

  Future<void> _refreshData() async {
    return await ref.refresh(currentUserDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserDataProvider).when(
          data: (currentUser) => Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                          Positioned(
                            left: 120,
                            top: 20,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                currentUser.profilePic,
                              ),
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "Name",
                              onSave: (displayName) async {
                                await ref
                                    .watch(editSettingsFieldProvider)
                                    .editDisplayName(
                                      displayName: displayName,
                                    );
                              },
                            ),
                          );
                        },
                        value: currentUser.displayName,
                      ),
                      const Gap(10),
                      SettingsItem(
                        identifier: "Handle",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "Username",
                              onSave: (username) async {
                                await ref
                                    .watch(editSettingsFieldProvider)
                                    .editUsername(
                                      username: username,
                                    );
                              },
                            ),
                          );
                        },
                        value: currentUser.username,
                      ),
                      const Gap(10),
                      SettingsItem(
                        identifier: "Description",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "Description",
                              onSave: (description) async {
                                await ref
                                    .watch(editSettingsFieldProvider)
                                    .editDescription(
                                      description: description,
                                    );
                              },
                            ),
                          );
                        },
                        value: currentUser.description,
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
              ),
            ),
          ),
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
