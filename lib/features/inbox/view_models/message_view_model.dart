import 'dart:async';

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
      final message = MessageModel(text: text, userId: user!.uid);
      await _repo.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);
