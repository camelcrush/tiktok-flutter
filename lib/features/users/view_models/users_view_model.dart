import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/users/models/user_model.dart';
import 'package:tiktokapp/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;

  @override
  FutureOr<UserProfileModel> build() {
    _userRepo = ref.read(userRepo);
    // Profile 생성을 위해 UserProfileModel State값을 빈 값으로 초기화
    // 이후에 createProfile로 State값 업데이트
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    // SignupViewModel로부터 받은 credential 값을 통해 Profile 만들기
    if (credential.user == null) {
      throw Exception("Can't create Account");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: credential.user!.displayName ?? "Anon",
      bio: "undefined",
      link: "undefined",
    );
    // UserRepository에서 Firestore profile 생성
    await _userRepo.createProfile(profile);
    // state값 업데이트
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
