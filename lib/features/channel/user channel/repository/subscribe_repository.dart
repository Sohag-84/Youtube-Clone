import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscribeChannelProvider = Provider(
  (ref) => SubscribeRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SubscribeRepository {
  FirebaseFirestore? firestore;
  SubscribeRepository({
    required this.firestore,
  });

  Future<void> subscribeChannel({
    required userId,
    required currentUserId,
    required List subscriptions,
  }) async {
    if (!subscriptions.contains([currentUserId])) {
      await firestore!.collection("users").doc(userId).update(
        {
          "subscriptions": FieldValue.arrayUnion([currentUserId]),
        },
      );
    }
    if (subscriptions.contains([currentUserId])) {
      await firestore!.collection("users").doc(userId).update(
        {
          "subscriptions": FieldValue.arrayRemove([currentUserId]),
        },
      );
    }
  }
}
