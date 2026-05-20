import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/authentication/data/model/verify_otp_response_model.dart';

class OtpVerificationService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<VerifyOtpResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final body = {
      'email': email,
      'otp': otp,
    };

    AppLoggerHelper.debug('VERIFY OTP REQUEST => POST ${ApiConstants.verifyOtp}');
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.postRequest(
      ApiConstants.verifyOtp,
      body: body,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'VERIFY OTP RESPONSE <= ${response.statusCode} ${ApiConstants.verifyOtp}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = VerifyOtpResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception(
          model.message.isNotEmpty ? model.message : 'OTP verification failed',
        );
      }
      return model;
    }

    throw Exception(_extractErrorMessage(response.errorMessage, response.responseData));
  }

  String _extractErrorMessage(String errorMessage, dynamic responseData) {
    if (errorMessage.isNotEmpty) return errorMessage;
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message']?.toString();
      if (message != null && message.isNotEmpty) return message;
    }
    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }
    return 'OTP verification failed';
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
