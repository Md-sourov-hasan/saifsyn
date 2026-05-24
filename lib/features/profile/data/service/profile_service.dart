import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/profile/data/model/change_password_response_model.dart';
import 'package:saifsyn/features/profile/data/model/profile_response_model.dart';

class ProfileService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ProfileResponseModel> getProfile() async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken = token.toLowerCase().startsWith('bearer ')
        ? token
        : 'Bearer $token';

    AppLoggerHelper.debug('PROFILE REQUEST => GET ${ApiConstants.profile}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Authorization': authToken,
          })}',
    );

    final response = await _networkCaller.getRequest(
      ApiConstants.profile,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'PROFILE RESPONSE <= ${response.statusCode} ${ApiConstants.profile}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    debugPrint("=== GET PROFILE RAW API RESPONSE ===");
    debugPrint(_toPrettyJson(response.responseData));
    debugPrint("====================================");

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = ProfileResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception('Failed to load profile');
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to load profile',
    );
  }

  Future<ProfileResponseModel> updateProfile({
    required String name,
    required String phone,
    required String email,
    required String dateOfBirth,
    required String occupation,
    required String bio,
  }) async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken = token.toLowerCase().startsWith('bearer ')
        ? token
        : 'Bearer $token';

    final body = <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'Date of Birth': dateOfBirth,
      'occupation': occupation,
      'Bio': bio,
    };

    AppLoggerHelper.debug('UPDATE PROFILE REQUEST => PUT ${ApiConstants.updateProfile}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': authToken,
          })}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.putRequest(
      ApiConstants.updateProfile,
      body: body,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'UPDATE PROFILE RESPONSE <= ${response.statusCode} ${ApiConstants.updateProfile}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = ProfileResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception(
          model.message.isNotEmpty ? model.message : 'Failed to update profile',
        );
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to update profile',
    );
  }

  Future<ChangePasswordResponseModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }

    final authToken = token.toLowerCase().startsWith('bearer ')
        ? token
        : 'Bearer $token';

    final body = <String, dynamic>{
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };

    AppLoggerHelper.debug('CHANGE PASSWORD REQUEST => PUT ${ApiConstants.changePassword}');
    AppLoggerHelper.debug(
      'REQUEST HEADERS => ${_toPrettyJson(<String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': authToken,
          })}',
    );
    AppLoggerHelper.debug('REQUEST BODY => ${_toPrettyJson(body)}');

    final response = await _networkCaller.putRequest(
      ApiConstants.changePassword,
      body: body,
      token: authToken,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'CHANGE PASSWORD RESPONSE <= ${response.statusCode} ${ApiConstants.changePassword}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final model = ChangePasswordResponseModel.fromJson(
        response.responseData as Map<String, dynamic>,
      );
      if (!model.success) {
        throw Exception(
          model.message.isNotEmpty ? model.message : 'Failed to change password',
        );
      }
      return model;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to change password',
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
