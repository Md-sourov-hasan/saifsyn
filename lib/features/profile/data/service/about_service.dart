import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/profile/data/model/about_response_model.dart';

class AboutService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<AboutResponseModel> getAbout() async {
    AppLoggerHelper.debug('ABOUT REQUEST => GET ${ApiConstants.about}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(const <String, String>{
            'Accept': 'application/json',
          })}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.about,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'ABOUT RESPONSE <= ${response.statusCode} ${ApiConstants.about}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = AboutResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception('Failed to load about us');
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to load about us',
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
