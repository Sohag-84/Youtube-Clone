import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

class UsernamePage extends ConsumerStatefulWidget {
  final String displayname;
  final String profilePic;
  final String email;
  const UsernamePage({
    super.key,
    required this.displayname,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  bool isValidate = true;

  void validateUsername() async {
    final userMap = await FirebaseFirestore.instance.collection('users').get();

    final users = userMap.docs.map((user) => user).toList();

    String? targetedUser;
    for (var user in users) {
      if (usernameController.text == user.data()['username']) {
        targetedUser = user.data()['username'];
        isValidate = false;
        setState(() {});
      }
      if (usernameController.text != targetedUser) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26, horizontal: 14),
              child: Text(
                "Enter the username",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),

            ///text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: usernameController,
                  onChanged: (username) {
                    validateUsername();
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (username) {
                    return isValidate ? null : "username allready taken";
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      isValidate ? Icons.verified_user_rounded : Icons.cancel,
                    ),
                    suffixIconColor: isValidate ? Colors.green : Colors.red,
                    hintText: "Insert username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 10, right: 10),
              child: FlatButton(
                text: "CONTINUE",
                onPressed: () async {
                  ///add user data inside database
                  isValidate
                      ? await ref
                          .read(userDataServiceProvider)
                          .addUserDataToFirestore(
                            displayName: widget.displayname,
                            username: usernameController.text,
                            email: widget.email,
                            description: "",
                            profilePic: widget.profilePic,
                          )
                      : null;
                },
                colour: isValidate ? Colors.green : Colors.green.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
