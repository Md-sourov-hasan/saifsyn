import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/notifications/data/model/bell_notification_model.dart';

class NotificationService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<BellNotificationsResponseModel> getBellNotifications() async {
    final authToken = _requireAuthToken();

    AppLoggerHelper.debug(
      'NOTIFICATIONS REQUEST => GET ${ApiConstants.bellNotifications}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.bellNotifications,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'NOTIFICATIONS RESPONSE <= ${response.statusCode} ${ApiConstants.bellNotifications}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = BellNotificationsResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception('Failed to fetch notifications.');
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch notifications.',
    );
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    if (notificationId <= 0) {
      throw Exception('Invalid notification id.');
    }

    final authToken = _requireAuthToken();
    final endpoint = ApiConstants.markNotificationAsRead(notificationId);

    AppLoggerHelper.debug('NOTIFICATION READ REQUEST => POST $endpoint');

    final response = await _networkCaller.postRequest(
      endpoint,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'NOTIFICATION READ RESPONSE <= ${response.statusCode} $endpoint',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final responseMap = response.responseData as Map<String, dynamic>;
      final success = responseMap['success'];
      final isSuccess = success is bool
          ? success
          : success?.toString().toLowerCase() == 'true';

      if (isSuccess) {
        return;
      }

      throw Exception(
        responseMap['message']?.toString() ??
            'Failed to mark notification as read.',
      );
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to mark notification as read.',
    );
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
