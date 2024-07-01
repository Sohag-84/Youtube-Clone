import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSettingsFieldProvider = Provider(
  (ref) => EditSettingsField(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class EditSettingsField {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  EditSettingsField({
    required this.auth,
    required this.firestore,
  });

  ///for edit display name
  editDisplayName({required String displayName}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({"displayName": displayName});
  }

  ///for edit username
  editUsername({required String username}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({"username": username});
  }

  ///for edit description
  editDescription({required String description}) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({"description": description});
  }
}
