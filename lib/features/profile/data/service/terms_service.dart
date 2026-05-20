import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/profile/data/model/terms_response_model.dart';

class TermsService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<TermsResponseModel> getTerms() async {
    AppLoggerHelper.debug('TERMS REQUEST => GET ${ApiConstants.terms}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(const <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          })}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.terms,
      headers: const {
        'Accept': 'application/json',
      },
    );

    AppLoggerHelper.debug(
      'TERMS RESPONSE <= ${response.statusCode} ${ApiConstants.terms}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = TermsResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception('Failed to load terms and conditions');
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to load terms and conditions',
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
