class MessageModel {
  final String text;
  final String userId;
  final int createdAt;
  final String id;

  MessageModel(
      {required this.text,
      required this.userId,
      required this.createdAt,
      required this.id});

  MessageModel.fromJson(
      {required Map<String, dynamic> json, required String messageId})
      : text = json['text'],
        userId = json['userId'],
        createdAt = json['createdAt'],
        id = messageId;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  MessageModel copyWith({
    String? text,
  }) {
    return MessageModel(
      text: text ?? this.text,
      userId: userId,
      createdAt: createdAt,
      id: id,
    );
  }
}
