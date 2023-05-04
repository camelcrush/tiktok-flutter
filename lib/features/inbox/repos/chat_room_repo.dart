import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/inbox/models/chat_room_model.dart';

class ChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createChatRoom(ChatRoomModel chatRoom) async {
    await _db
        .collection("chat_rooms")
        .doc("${chatRoom.personA}000${chatRoom.personB}")
        .set({
      ...chatRoom.toJson(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });

    return "${chatRoom.personA}000${chatRoom.personB}";
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchChatRooms(String uid) async {
    final query =
        await _db.collection("users").doc(uid).collection("chat_rooms").get();
    return query;
  }
}

final chatRoomRepo = Provider(
  (ref) => ChatRoomRepository(),
);
