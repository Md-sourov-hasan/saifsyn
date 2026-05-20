import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/analysis/data/model/company_analysis_models.dart';

class CompanyAnalysisService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<CompanyAnalysisResult> analyzeCompany({
    required String userId,
    required int planId,
    required String companyName,
    required String language,
  }) async {
    final response = await _networkCaller.postRequest(
      ApiConstants.companyAnalysis,
      headers: const {'Accept': 'application/json'},
      body: {
        'user_id': userId,
        'plan_id': planId,
        'company_name': companyName,
        'language': language,
      },
    );

    _logResponse('POST', ApiConstants.companyAnalysis, response.responseData);

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return CompanyAnalysisResult.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to analyze company.',
    );
  }

  Future<List<AnalysisHistoryItem>> getHistory(String userId) async {
    final url = ApiConstants.analysisHistory(userId);
    final response = await _networkCaller.getRequest(
      url,
      headers: const {'Accept': 'application/json'},
    );

    _logResponse('GET', url, response.responseData);

    if (response.isSuccess && response.responseData is List) {
      return (response.responseData as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map(AnalysisHistoryItem.fromJson)
          .toList();
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch analysis history.',
    );
  }

  Future<CompanyAnalysisResult> getResult(String id) async {
    final url = ApiConstants.analysisResult(id);
    final response = await _networkCaller.getRequest(
      url,
      headers: const {'Accept': 'application/json'},
    );

    _logResponse('GET', url, response.responseData);

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return CompanyAnalysisResult.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch analysis result.',
    );
  }

  void _logResponse(String method, String url, dynamic payload) {
    AppLoggerHelper.debug('$method $url');
    try {
      AppLoggerHelper.debug(
        const JsonEncoder.withIndent('  ').convert(payload),
      );
    } catch (_) {
      AppLoggerHelper.debug(payload.toString());
    }
  }
}
