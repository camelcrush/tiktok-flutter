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

  Future<void> deleteMessage(String messageId, String chatId) async {
    _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .doc(messageId)
        .update({'text': '[deleted message]'});
  }
}

final messageRepo = Provider((ref) => MessageRepository());
