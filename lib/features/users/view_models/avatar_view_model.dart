import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/users/repos/user_repo.dart';
import 'package:tiktokapp/features/users/view_models/users_view_model.dart';
import 'package:tiktokapp/utils.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepo;

  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userRepo);
  }

  // Avatar Upload
  Future<void> uploadAvatar(File file, BuildContext context) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        // fireStorage에 file 업로드
        await _userRepo.uploadAvatar(file, fileName);
        // userViewModel state값 변경 및 firestore에 유저 프로필 업데이트
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
