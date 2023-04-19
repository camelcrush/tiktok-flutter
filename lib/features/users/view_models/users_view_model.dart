import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/users/models/user_model.dart';
import 'package:tiktokapp/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    // User가 로그인 상태라면 인증된 유저데이터를 State값으로 초기화
    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    // Profile 생성을 위해 UserProfileModel State값을 빈 값으로 초기화
    // 이후에 createProfile로 State값 업데이트
    return UserProfileModel.empty();
  }

  Future<void> createProfile({
    required UserCredential credential,
    String email = "",
    String name = "",
    String birthday = "",
  }) async {
    // SignupViewModel로부터 받은 credential 값을 통해 Profile 만들기
    if (credential.user == null) {
      throw Exception("Can't create Account");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? email,
      name: credential.user!.displayName ?? name,
      bio: "undefined",
      link: "undefined",
      birthday: birthday,
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
