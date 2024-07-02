import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

final userDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  UserDataService({required this.auth, required this.firestore});

  addUserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String description,
    required String profilePic,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: profilePic,
      subscriptions: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );

//to store user in firebase
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

  ///for get current user data
  Future<UserModel> fetchedCurrentUserData() async {
    final currentUserMap =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }

  ///for get user data
  Future<UserModel> fetchedAnyUserData({required userId}) async {
    final userMap = await firestore.collection('users').doc(userId).get();

    UserModel user = UserModel.fromMap(userMap.data()!);
    return user;
  }
}
