import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/authentication/data/model/login_response_model.dart';
import 'package:saifsyn/features/authentication/data/model/register_response_model.dart';
import 'package:saifsyn/features/authentication/data/model/terms_response_model.dart';

class AuthService {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };

    AppLoggerHelper.debug('LOGIN REQUEST => POST ${ApiConstants.login}');
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    try {
      final http.Response response = await http
          .post(
            Uri.parse(ApiConstants.login),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 60));

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = response.body;
      }

      AppLoggerHelper.debug(
        'LOGIN RESPONSE <= ${response.statusCode} ${ApiConstants.login}',
      );
      AppLoggerHelper.debug('RESPONSE BODY => ${_toPrettyJson(decoded)}');

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          decoded is Map<String, dynamic>) {
        final model = LoginResponseModel.fromJson(decoded);
        if (!model.success) {
          throw Exception(
            model.message.isNotEmpty ? model.message : 'Login failed',
          );
        }
        return model;
      }

      throw Exception(
          _extractErrorMessage('', decoded, fallback: 'Login failed'));
    } on TimeoutException {
      throw Exception(
        'Request timeout. API did not respond within 60 seconds.',
      );
    } on SocketException {
      throw Exception(
        'Unable to connect to server. Check internet or server availability.',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Login failed: $e');
    }
  }

  Future<RegisterResponseModel> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
    String role = 'user',
    bool termsAccepted = true,
  }) async {
    final body = {
      'name':name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'role': role,
      'terms_accepted': termsAccepted,
    };

    AppLoggerHelper.debug('REGISTER REQUEST => POST ${ApiConstants.register}');
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    try {
      final http.Response response = await http
          .post(
            Uri.parse(ApiConstants.register),
            headers: const {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 60));

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = response.body;
      }

      AppLoggerHelper.debug(
        'REGISTER RESPONSE <= ${response.statusCode} ${ApiConstants.register}',
      );
      AppLoggerHelper.debug('RESPONSE BODY => ${_toPrettyJson(decoded)}');

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          decoded is Map<String, dynamic>) {
        final model = RegisterResponseModel.fromJson(decoded);
        if (!model.success) {
          throw Exception(
            model.message.isNotEmpty ? model.message : 'Registration failed',
          );
        }
        return model;
      }

      throw Exception(
        _extractErrorMessage('', decoded, fallback: 'Registration failed'),
      );
    } on TimeoutException {
      throw Exception(
        'Request timeout. API did not respond within 60 seconds.',
      );
    } on SocketException {
      throw Exception(
        'Unable to connect to server. Check internet or server availability.',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Registration failed: $e');
    }
  }

  Future<AuthTermsResponseModel> getTermsAndConditions() async {
    AppLoggerHelper.debug('TERMS REQUEST => GET ${ApiConstants.terms}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(const <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          })}',
    );

    try {
      final http.Response response = await http.get(
        Uri.parse(ApiConstants.terms),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 60));

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = response.body;
      }

      AppLoggerHelper.debug(
        'TERMS RESPONSE <= ${response.statusCode} ${ApiConstants.terms}',
      );
      AppLoggerHelper.debug('RESPONSE BODY => ${_toPrettyJson(decoded)}');

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          decoded is Map<String, dynamic>) {
        final model = AuthTermsResponseModel.fromJson(decoded);
        if (!model.success) {
          throw Exception('Failed to load terms and conditions');
        }
        return model;
      }

      throw Exception(
        _extractErrorMessage(
          '',
          decoded,
          fallback: 'Failed to load terms and conditions',
        ),
      );
    } on TimeoutException {
      throw Exception(
        'Request timeout. API did not respond within 60 seconds.',
      );
    } on SocketException {
      throw Exception(
        'Unable to connect to server. Check internet or server availability.',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to load terms and conditions: $e');
    }
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
