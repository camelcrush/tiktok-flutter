class ChatRoomModel {
  final String chatRoomId;
  final String personA;
  final String personB;

  ChatRoomModel({
    required this.chatRoomId,
    required this.personA,
    required this.personB,
  });

  ChatRoomModel.fromJson(
      {required Map<String, dynamic> json, required String id})
      : chatRoomId = id,
        personA = json['personA'],
        personB = json['personB'];

  Map<String, dynamic> toJson() {
    return {
      'personA': personA,
      'personB': personB,
    };
  }

  ChatRoomModel copyWith({
    String? chatRoomId,
    String? personA,
    String? personB,
  }) {
    return ChatRoomModel(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      personA: personA ?? this.personA,
      personB: personB ?? this.personB,
    );
  }
}
