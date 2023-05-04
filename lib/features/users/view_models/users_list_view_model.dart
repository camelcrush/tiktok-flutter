import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/users/models/user_model.dart';
import 'package:tiktokapp/features/users/repos/user_repo.dart';

class UsersListViewModel extends AsyncNotifier<List<UserProfileModel>> {
  late final UserRepository _userRepo;
  List<UserProfileModel> _list = [];

  Future<List<UserProfileModel>> getUserList() async {
    final user = ref.read(authRepo).user!;
    final result = await _userRepo.fetchUsers(user.uid);
    final users = result.docs
        .map((doc) => UserProfileModel.fromJson(doc.data()))
        .toList();
    return users.toList();
  }

  @override
  FutureOr<List<UserProfileModel>> build() async {
    _userRepo = ref.read(userRepo);
    _list = await getUserList();
    return _list;
  }
}

final usersListProvider =
    AsyncNotifierProvider<UsersListViewModel, List<UserProfileModel>>(
  () => UsersListViewModel(),
);
