import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/utils.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authRepo.githubSignIn());
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);


// Social Login Android 지문(Profile signature) 받는 방법
// android 폴더로 가서 ./gradlew signReport 실행
// Profile Section에 Sha1 코드 복사하여 Firebase Console 셋팅창 > Finger Print에 저장