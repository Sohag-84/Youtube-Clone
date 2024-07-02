import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

final currentUserDataProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchedCurrentUserData();
  return user;
});

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserModel user = await ref
      .watch(userDataServiceProvider)
      .fetchedAnyUserData(userId: userId);

  return user;
});
