import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/massages/data/model/chat_message_model.dart';
import 'package:saifsyn/features/massages/data/model/chat_response_model.dart';

class ChatServices {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<List<ChatMessageModel>> getFullConversation({
    required int senderId,
    required int receiverId,
  }) async {
    if (senderId <= 0 || receiverId <= 0) {
      throw Exception('Invalid sender or receiver id for conversation.');
    }

    final authToken = _requireAuthToken();
    final url = ApiConstants.getConversation(
      senderId: senderId,
      receiverId: receiverId,
    );

    AppLoggerHelper.debug('CHAT REQUEST => GET $url');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': authToken,
          })}',
    );

    final response = await _networkCaller.getRequest(
      url,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    AppLoggerHelper.debug('CHAT RESPONSE <= ${response.statusCode} $url');
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to load conversation',
      );
    }

    if (response.responseData is! Map<String, dynamic>) {
      throw Exception('Unexpected conversation response format');
    }

    final model = ChatConversationResponseModel.fromJson(
      response.responseData as Map<String, dynamic>,
    );

    if (!model.status) {
      throw Exception('Conversation API returned an unsuccessful status');
    }

    return model.data;
  }

  Future<List<ChatMessageModel>> getMessagesByUserId(int userId) async {
    if (userId <= 0) {
      throw Exception('Invalid user id for chat.');
    }

    final authToken = _requireAuthToken();
    final url = ApiConstants.getChatByUserId(userId);

    AppLoggerHelper.debug('CHAT REQUEST => GET $url');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Authorization': authToken,
          })}',
    );

    final response = await _networkCaller.getRequest(
      url,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
    );

    AppLoggerHelper.debug('CHAT RESPONSE <= ${response.statusCode} $url');
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to load massages',
      );
    }

    if (response.responseData is! Map<String, dynamic>) {
      throw Exception('Unexpected chat response format');
    }

    final model = ChatConversationResponseModel.fromJson(
      response.responseData as Map<String, dynamic>,
    );

    if (!model.status) {
      throw Exception('Chat API returned an unsuccessful status');
    }

    return model.data;
  }

  Future<ChatMessageModel> sendMessage({
    required int receiverId,
    required String message,
  }) async {
    if (receiverId <= 0) {
      throw Exception('Invalid receiver id.');
    }

    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) {
      throw Exception('Message cannot be empty.');
    }

    final authToken = _requireAuthToken();
    final body = <String, dynamic>{
      'receiver_id': receiverId,
      'message': trimmedMessage,
    };

    AppLoggerHelper.debug('SEND CHAT REQUEST => POST ${ApiConstants.sendChat}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': authToken,
          })}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.postRequest(
      ApiConstants.sendChat,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
      body: body,
    );

    AppLoggerHelper.debug(
      'SEND CHAT RESPONSE <= ${response.statusCode} ${ApiConstants.sendChat}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to send message',
      );
    }

    if (response.responseData is! Map<String, dynamic>) {
      throw Exception('Unexpected send chat response format');
    }

    final model = SendChatResponseModel.fromJson(
      response.responseData as Map<String, dynamic>,
    );

    if (!model.status || model.data == null) {
      throw Exception(
        model.message.isNotEmpty ? model.message : 'Failed to send message',
      );
    }

    return model.data!;
  }

  String _requireAuthToken() {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }
    return token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token';
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
