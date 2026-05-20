class ChatUserModel {
  final int id;
  final String name;

  const ChatUserModel({
    required this.id,
    required this.name,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return ChatUserModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }
}

class ChatMessageModel {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final ChatUserModel? sender;
  final ChatUserModel? receiver;

  const ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sender,
    this.receiver,
  });

  DateTime? get timestamp => createdAt ?? updatedAt;

  bool isFromUser(int userId) => senderId == userId;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final senderIdValue = json['sender_id'];
    final receiverIdValue = json['receiver_id'];

    return ChatMessageModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      senderId: senderIdValue is int
          ? senderIdValue
          : int.tryParse(senderIdValue.toString()) ?? 0,
      receiverId: receiverIdValue is int
          ? receiverIdValue
          : int.tryParse(receiverIdValue.toString()) ?? 0,
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(json['deleted_at']?.toString() ?? ''),
      sender: json['sender'] is Map<String, dynamic>
          ? ChatUserModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      receiver: json['receiver'] is Map<String, dynamic>
          ? ChatUserModel.fromJson(json['receiver'] as Map<String, dynamic>)
          : null,
    );
  }
}
