import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/authentication/data/service/password_recovery_service.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  // Text editing controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  final _isNewPasswordVisible = false.obs;
  final _isConfirmPasswordVisible = false.obs;
  final _isLoading = false.obs;

  // Password strength indicators
  final _hasUpperCase = false.obs;
  final _hasLowerCase = false.obs;
  final _hasDigit = false.obs;
  final _hasSpecialChar = false.obs;
  final _hasMinLength = false.obs;

  // Getters
  bool get isNewPasswordVisible => _isNewPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  bool get isLoading => _isLoading.value;
  bool get hasUpperCase => _hasUpperCase.value;
  bool get hasLowerCase => _hasLowerCase.value;
  bool get hasDigit => _hasDigit.value;
  bool get hasSpecialChar => _hasSpecialChar.value;
  bool get hasMinLength => _hasMinLength.value;

  // Form key for validation
  final formKey = GlobalKey<FormState>();
  final PasswordRecoveryService _passwordRecoveryService =
      PasswordRecoveryService();
  String email = '';

  @override
  void onInit() {
    super.onInit();
    // Listen to password changes to update strength indicators
    newPasswordController.addListener(_updatePasswordStrength);

    final args = Get.arguments;
    if (args is String) {
      email = args;
    } else if (args is Map<String, dynamic>) {
      email = args['email']?.toString() ?? '';
    }
  }

  /// Toggle new password visibility
  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible.value = !_isNewPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  /// Update password strength indicators
  void _updatePasswordStrength() {
    final password = newPasswordController.text;

    _hasUpperCase.value = password.contains(RegExp(r'[A-Z]'));
    _hasLowerCase.value = password.contains(RegExp(r'[a-z]'));
    _hasDigit.value = password.contains(RegExp(r'[0-9]'));
    _hasSpecialChar.value =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    _hasMinLength.value = password.length >= 8;
  }

  /// Validate new password
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  /// Validate confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Reset password
  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (email.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required to reset password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      _isLoading.value = true;
      final response = await _passwordRecoveryService.resetPassword(
        email: email.trim(),
        newPassword: newPasswordController.text.trim(),
        newPasswordConfirmation: confirmPasswordController.text.trim(),
      );

      Get.snackbar(
        'Success',
        response.message.isNotEmpty
            ? response.message
            : 'Password reset successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );

      // Navigate back to login screen
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoute.getLoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (!isClosed) {
        _isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    newPasswordController.removeListener(_updatePasswordStrength);
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
