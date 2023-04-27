import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';

class NotificationsProvider extends AsyncNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // user Doc에 FCM Token 업데이트
  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    if (user == null) return;
    await _db.collection("users").doc(user.uid).update({'token': token});
  }

  @override
  FutureOr build() async {
    // FCM으로부터 notification Token 받아오기
    // Returns the default FCM token for this device.
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    // FCM에서 Token이 갱신되면 자동으로 user data에 업데이트
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider(
  () => NotificationsProvider(),
);
