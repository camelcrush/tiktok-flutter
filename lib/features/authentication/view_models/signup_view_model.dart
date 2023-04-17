import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/onboarding/interests_screen.dart';
import 'package:tiktokapp/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    // AuthRepo 불러와서 초기화
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    // Creates an [AsyncValue] in loading state.
    // Prefer always using this constructor with the const keyword.
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    // AsyncValue.guard()는 try/catch 로직에 의거 데이터 작업 실시
    state = await AsyncValue.guard(
      () async => await _authRepo.emailSignUp(
        form['email'],
        form['password'],
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

// A provider which creates and listen to an [AsyncNotifier].
final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);

// A provider that exposes a value that can be modified from outside.
final signUpForm = StateProvider((ref) => {});
