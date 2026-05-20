import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/profile/data/model/contact_response_model.dart';

class ContactService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ContactResponseModel> sendContactMessage({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    final body = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'message': message,
    };

    AppLoggerHelper.debug('CONTACT REQUEST => POST ${ApiConstants.contact}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(const <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          })}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.postRequest(
      ApiConstants.contact,
      body: body,
      headers: const {
        'Accept': 'application/json',
      },
    );

    AppLoggerHelper.debug(
      'CONTACT RESPONSE <= ${response.statusCode} ${ApiConstants.contact}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return ContactResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to send your message',
    );
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
