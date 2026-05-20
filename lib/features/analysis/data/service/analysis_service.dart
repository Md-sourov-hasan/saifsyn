import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/analysis/data/model/analysis_response_model.dart';

class AnalysisService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<AnalysisResponseModel> getAnalyses() async {
    final token = StorageService.token?.trim() ?? '';
    final authToken = token.isEmpty
        ? null
        : (token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token');

    AppLoggerHelper.debug('ANALYSES REQUEST => GET ${ApiConstants.analyses}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            if (authToken != null) 'Authorization': authToken,
          })}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.analyses,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'ANALYSES RESPONSE <= ${response.statusCode} ${ApiConstants.analyses}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = AnalysisResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );

      if (!model.success) {
        throw Exception('Failed to fetch analyses.');
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch analyses.',
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
