import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/profile/data/service/profile_service.dart';

class ChangePasswordController extends GetxController {
  final ProfileService _profileService = ProfileService();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LocalizationService>()
          .translate('pleaseEnterCurrentPassword');
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LocalizationService>()
          .translate('pleaseEnterNewPassword');
    }
    if (value.length < 8) {
      return Get.find<LocalizationService>().translate('passwordMin8');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return Get.find<LocalizationService>()
          .translate('passwordMustContainUppercase');
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return Get.find<LocalizationService>()
          .translate('passwordMustContainLowercase');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return Get.find<LocalizationService>()
          .translate('passwordMustContainNumber');
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return Get.find<LocalizationService>()
          .translate('passwordMustContainSpecialChar');
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Get.find<LocalizationService>()
          .translate('pleaseConfirmNewPassword');
    }
    if (value != newPasswordController.text) {
      return Get.find<LocalizationService>().translate('passwordsDoNotMatch');
    }
    return null;
  }

  Future<String> changePassword() async {
    _isLoading.value = true;
    try {
      final response = await _profileService.changePassword(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        newPasswordConfirmation: confirmPasswordController.text.trim(),
      );
      return response.message.isNotEmpty
          ? response.message
          : 'Password changed successfully';
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
