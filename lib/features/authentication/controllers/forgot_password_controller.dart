import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/authentication/data/service/password_recovery_service.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  // Text editing controller
  final emailController = TextEditingController();

  // Observable states
  final _isLoading = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;

  // Form key for validation
  final formKey = GlobalKey<FormState>();
  final PasswordRecoveryService _passwordRecoveryService =
      PasswordRecoveryService();

  /// Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Request password reset code
  Future<void> requestResetCode() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();

    try {
      _isLoading.value = true;

      final response = await _passwordRecoveryService.forgotPassword(
        email: email,
      );

      Get.snackbar(
        'Success',
        response.message.isNotEmpty
            ? response.message
            : 'Reset code sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );

      // Navigate to OTP verification screen
      Get.toNamed(
        AppRoute.getOtpVerificationScreen(),
        arguments: {
          'email': email,
          'purpose': 'forgot_password',
        },
      );
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

  /// Navigate back to login
  void navigateBackToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
