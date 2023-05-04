import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/inbox/chat_detail_screen.dart';
import 'package:tiktokapp/features/inbox/models/chat_room_model.dart';
import 'package:tiktokapp/features/inbox/repos/chat_room_repo.dart';

class ChatsViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepository _chatRoomRepository;
  List<ChatRoomModel> _list = [];

  Future<void> createChatRoom(String personBId, BuildContext context) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user!;
    final newChatRoom = ChatRoomModel(
      chatRoomId: '',
      personA: user.uid,
      personB: personBId,
    );
    final createdChatRoomId =
        await _chatRoomRepository.createChatRoom(newChatRoom);
    state = AsyncValue.data([
      newChatRoom.copyWith(chatRoomId: "${user.uid}000$personBId"),
      ..._list
    ]);
    context.pushNamed(ChatDetailScreen.routeName,
        params: {'chatId': createdChatRoomId});
  }

  Future<List<ChatRoomModel>> _fetchChatRooms() async {
    final user = ref.read(authRepo).user!;
    final result = await _chatRoomRepository.fetchChatRooms(user.uid);
    final chatRooms = result.docs.map(
      (doc) => ChatRoomModel.fromJson(
        json: doc.data(),
        id: doc.id,
      ),
    );
    return chatRooms.toList();
  }

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _chatRoomRepository = ref.read(chatRoomRepo);
    _list = await _fetchChatRooms();
    return _list;
  }
}

final chatsProvider =
    AsyncNotifierProvider<ChatsViewModel, List<ChatRoomModel>>(
  () => ChatsViewModel(),
);

final chatRoomStreamProvider =
    StreamProvider.autoDispose<List<ChatRoomModel>>((ref) {
  final user = ref.read(authRepo).user!;
  final db = FirebaseFirestore.instance;

  return db
      .collection("users")
      .doc(user.uid)
      .collection("chat_rooms")
      .orderBy("createdAt")
      .snapshots()
      .map((event) => event.docs
          .map(
            (doc) => ChatRoomModel.fromJson(
              json: doc.data(),
              id: doc.id,
            ),
          )
          .toList());
});
