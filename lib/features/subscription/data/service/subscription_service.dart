import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/subscription/data/model/payment_process_response.dart';
import 'package:saifsyn/features/subscription/data/model/payment_status_response.dart';
import 'package:saifsyn/features/subscription/data/model/subscription_plan_model.dart';

class SubscriptionService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<List<SubscriptionPlanModel>> getAllSubscriptions() async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken =
        token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token';

    AppLoggerHelper.debug(
      'SUBSCRIPTIONS REQUEST => GET ${ApiConstants.getAllSubscriptions}',
    );
    AppLoggerHelper.debug('REQUEST HEADERS => ${_toPrettyJson(<String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': authToken,
        })}');

    final response = await _networkCaller.getRequest(
      ApiConstants.getAllSubscriptions,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
    );

    AppLoggerHelper.debug(
      'SUBSCRIPTIONS RESPONSE <= ${response.statusCode} ${ApiConstants.getAllSubscriptions}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to fetch subscriptions',
      );
    }

    if (response.responseData is! List) {
      throw Exception('Unexpected subscriptions response format');
    }

    final List<dynamic> rawList = response.responseData as List<dynamic>;
    return rawList
        .whereType<Map<String, dynamic>>()
        .map(SubscriptionPlanModel.fromJson)
        .toList();
  }

  Future<PaymentProcessResponse> processPayment({
    required int planId,
    String platform = 'web',
  }) async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken =
        token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token';

    AppLoggerHelper.debug(
      'PAYMENT REQUEST => POST ${ApiConstants.processPayment}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(<String, dynamic>{
          'plan_id': planId,
          'platform': platform,
        })}');

    final response = await _networkCaller.postRequest(
      ApiConstants.processPayment,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
      body: <String, dynamic>{
        'plan_id': planId,
        'platform': platform,
      },
    );

    AppLoggerHelper.debug(
      'PAYMENT RESPONSE <= ${response.statusCode} ${ApiConstants.processPayment}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to process payment',
      );
    }

    if (response.responseData is! Map<String, dynamic>) {
      throw Exception('Unexpected payment response format');
    }

    final payment = PaymentProcessResponse.fromJson(
        response.responseData as Map<String, dynamic>);
    if (!payment.success || payment.checkoutUrl.isEmpty) {
      throw Exception('Payment checkout URL not available');
    }
    return payment;
  }

  Future<PaymentStatusResponse> getPaymentStatus() async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken =
        token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token';

    AppLoggerHelper.debug(
      'PAYMENT STATUS REQUEST => GET ${ApiConstants.showPayment}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.showPayment,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
    );

    AppLoggerHelper.debug(
      'PAYMENT STATUS RESPONSE <= ${response.statusCode} ${ApiConstants.showPayment}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (!response.isSuccess) {
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to load payment status',
      );
    }

    if (response.responseData is! Map<String, dynamic>) {
      throw Exception('Unexpected payment status response format');
    }

    final body = response.responseData as Map<String, dynamic>;
    final successValue = body['success'];
    final isSuccessFlag = successValue is bool
        ? successValue
        : successValue?.toString().toLowerCase() == 'true';
    if (!isSuccessFlag) {
      throw Exception(
        body['message']?.toString() ?? 'Failed to load payment status',
      );
    }

    return PaymentStatusResponse.fromJson(body);
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
