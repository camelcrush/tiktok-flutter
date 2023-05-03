import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/inbox/models/message_model.dart';
import 'package:tiktokapp/features/inbox/repos/message_repo.dart';

class MessageViewModel extends AsyncNotifier<void> {
  late final MessageRepository _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(messageRepo);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: '',
      );
      await _repo.sendMessage(message);
    });
  }

  Future<void> deleteMessage(String messageId, String chatId) async {
    await _repo.deleteMessage(messageId, chatId);
  }
}

final messagesProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

// StreamProvider : 채널(웹소켓)을 연결하여 listent상태로 유지 / autoDispose 필수
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc("SlBnqcYz38wcQYEdMz5A")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                json: doc.data(),
                messageId: doc.id,
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
});
