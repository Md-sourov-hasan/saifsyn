import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/authentication/data/model/forgot_password_response_model.dart';
import 'package:saifsyn/features/authentication/data/model/reset_password_response_model.dart';

class PasswordRecoveryService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  }) async {
    final body = {'email': email};

    AppLoggerHelper.debug(
      'FORGOT PASSWORD REQUEST => POST ${ApiConstants.forgotPassword}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.postRequest(
      ApiConstants.forgotPassword,
      body: body,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'FORGOT PASSWORD RESPONSE <= ${response.statusCode} ${ApiConstants.forgotPassword}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = ForgotPasswordResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception(
          model.message.isNotEmpty
              ? model.message
              : 'Failed to send password reset code',
        );
      }
      return model;
    }

    throw Exception(
      _extractErrorMessage(
        response.errorMessage,
        response.responseData,
        fallback: 'Failed to send password reset code',
      ),
    );
  }

  Future<ResetPasswordResponseModel> resetPassword({
    required String email,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final body = {
      'email': email,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };

    AppLoggerHelper.debug(
      'RESET PASSWORD REQUEST => POST ${ApiConstants.resetPassword}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.postRequest(
      ApiConstants.resetPassword,
      body: body,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'RESET PASSWORD RESPONSE <= ${response.statusCode} ${ApiConstants.resetPassword}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = ResetPasswordResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception(
          model.message.isNotEmpty ? model.message : 'Failed to reset password',
        );
      }
      return model;
    }

    throw Exception(
      _extractErrorMessage(
        response.errorMessage,
        response.responseData,
        fallback: 'Failed to reset password',
      ),
    );
  }

  String _extractErrorMessage(
    String errorMessage,
    dynamic responseData, {
    required String fallback,
  }) {
    if (errorMessage.isNotEmpty) return errorMessage;
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message']?.toString();
      if (message != null && message.isNotEmpty) return message;
    }
    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }
    return fallback;
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
