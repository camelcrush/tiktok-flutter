import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

// Firebase Error Message를 보여주기 위한 Flutter SnackBar
void showFirebaseErrorSnack(BuildContext context, Object? error) {
  // Manages [SnackBar]s and [MaterialBanner]s for descendant [Scaffold]s.
  // Scaffold 화면에서 팝업 메세지를 전달해주는 위젯
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text((error as FirebaseException).message ?? "Error"),
    ),
  );
}
