import 'chat_message_model.dart';

class ChatConversationResponseModel {
  final bool status;
  final List<ChatMessageModel> data;

  const ChatConversationResponseModel({
    required this.status,
    required this.data,
  });

  factory ChatConversationResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return ChatConversationResponseModel(
      status: _toBool(json['status'] ?? json['success']),
      data: rawData is List
          ? rawData
              .whereType<Map<String, dynamic>>()
              .map(ChatMessageModel.fromJson)
              .toList()
          : <ChatMessageModel>[],
    );
  }
}

class SendChatResponseModel {
  final bool status;
  final String message;
  final ChatMessageModel? data;

  const SendChatResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory SendChatResponseModel.fromJson(Map<String, dynamic> json) {
    return SendChatResponseModel(
      status: _toBool(json['status']),
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? ChatMessageModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

bool _toBool(dynamic value) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().toLowerCase().trim();
  return normalized == 'true' || normalized == '1';
}
