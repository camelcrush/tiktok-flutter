import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/inbox/models/message_model.dart';

class MessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("SlBnqcYz38wcQYEdMz5A")
        .collection("texts")
        .add(message.toJson());
  }
}

final messageRepo = Provider((ref) => MessageRepository());
