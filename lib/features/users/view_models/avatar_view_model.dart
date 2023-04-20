import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/users/repos/user_repo.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepo;

  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userRepo);
  }

  // Avatar Upload
  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async => await _userRepo.uploadAvatar(file, fileName),
    );
  }
}
