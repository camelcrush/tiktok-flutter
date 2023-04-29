import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/inbox/chats_screen.dart';
import 'package:tiktokapp/features/videos/views/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // user Doc에 FCM Token 업데이트
  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    if (user == null) return;
    await _db.collection("users").doc(user.uid).update({'token': token});
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) return;
    // foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I just got a message and I'm in the foreground.");
      print(event.notification?.title);
    });
    // background : flutter 3.0부터는  message는 main.dart background Handler로 처리
    // 만약 사용자가 notification을 클릭한다면 아래 코드가 작동
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage notification) {
      print(notification.data['screen']);
      context.pushNamed(ChatsScreen.routeName);
    });
    // terminated
    // If the application has been opened from a terminated state via a [RemoteMessage] (containing a [Notification]),
    // it will be returned, otherwise it will be null.
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    // FCM으로부터 notification Token 받아오기
    // Returns the default FCM token for this device.
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);
    // FCM에서 Token이 갱신되면 자동으로 user data에 업데이트
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
