import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/authentication/data/model/terms_response_model.dart';
import 'package:saifsyn/features/authentication/data/service/auth_service.dart';
import 'package:saifsyn/routes/app_routes.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _isPasswordVisible = false.obs;
  final _isConfirmPasswordVisible = false.obs;
  final _isLoading = false.obs;
  final _selectedRole = 'user'.obs;
  final _termsAccepted = false.obs;
  final _isTermsLoading = false.obs;
  final _termsErrorMessage = ''.obs;
  final Rxn<AuthTermsData> _termsData = Rxn<AuthTermsData>();

  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  bool get isLoading => _isLoading.value;
  String get selectedRole => _selectedRole.value;
  bool get termsAccepted => _termsAccepted.value;
  bool get isTermsLoading => _isTermsLoading.value;
  String get termsErrorMessage => _termsErrorMessage.value;
  AuthTermsData? get termsData => _termsData.value;

  String get localizedTermsContent {
    final content = _termsData.value?.content;
    if (content == null) return '';

    final languageCode = Get.isRegistered<LocalizationService>()
        ? Get.find<LocalizationService>().locale.languageCode
        : 'en';

    if (languageCode == 'bn') {
      return content.bn.isNotEmpty ? content.bn : content.en;
    }
    return content.en.isNotEmpty ? content.en : content.bn;
  }

  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    fetchTermsAndConditions();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  void setRole(String? role) {
    if (role == null || role.trim().isEmpty) return;
    _selectedRole.value = role.trim();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted.value = value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (value.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm password is required';
    if (value != passwordController.text.trim()) {
      return 'Password confirmation does not match';
    }
    return null;
  }

  String? validateRole(String? value) {
    if (value == null || value.trim().isEmpty) return 'Role is required';
    return null;
  }

  String? validateTermsAccepted(bool? value) {
    if (value != true) return 'You must accept terms and conditions';
    return null;
  }

  Future<void> fetchTermsAndConditions() async {
    try {
      _isTermsLoading.value = true;
      _termsErrorMessage.value = '';

      final response = await _authService.getTermsAndConditions();
      _termsData.value = response.data;

      if (response.data == null || !response.data!.isActive) {
        _termsErrorMessage.value = 'Terms and conditions are unavailable.';
      }
    } catch (e) {
      _termsErrorMessage.value =
          e.toString().replaceFirst('Exception: ', '').trim();
      _termsData.value = null;
    } finally {
      _isTermsLoading.value = false;
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final role = selectedRole;
    final terms = termsAccepted;

    try {
      _isLoading.value = true;

      final response = await _authService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: confirmPassword,
        role: role,
        termsAccepted: terms,
      );

      

      Get.snackbar(
        'Success',
        response.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      Get.toNamed(
        AppRoute.getOtpVerificationScreen(),
        arguments: {'email': email},
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        _mapSignUpError(e),
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

  String _mapSignUpError(Object error) {
    final message = error.toString().replaceFirst('Exception: ', '');
    if (message.toLowerCase().contains('timeout')) {
      return 'Server is not responding. Please check your internet connection.';
    }
    if (message.contains('SocketException')) {
      return 'Unable to connect to server. Please try again later.';
    }
    return message;
  }

  Future<void> signUpWithGoogle() async {
    try {
      _isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Google Sign-Up successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
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

  void navigateToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
