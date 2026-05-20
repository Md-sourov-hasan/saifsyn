import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/features/authentication/data/service/auth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final _isPasswordVisible = false.obs;
  final _isLoading = false.obs;

  // Getters
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isLoading => _isLoading.value;

  // Form key for validation
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    emailController.text = StorageService.email ?? '';
    passwordController.text = StorageService.password ?? '';
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

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

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Handle login
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      _isLoading.value = true;

      final response = await _authService.login(
        email: email,
        password: password,
      );

      final token = response.data?.token ?? '';
      final userId = response.data?.user?.id.toString() ?? '';
      if (token.isNotEmpty && userId.isNotEmpty) {
        await StorageService.saveToken(token, userId);
      }
      await StorageService.saveLoginCredentials(
        email: email,
        password: password,
      );

      Get.offAllNamed(AppRoute.getMainNavigationScreen());

      Get.snackbar(
        'Success',
        response.message.isNotEmpty ? response.message : 'Login successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        _mapLoginError(e),
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

  String _mapLoginError(Object error) {
    final message = error.toString().replaceFirst('Exception: ', '');
    if (message.toLowerCase().contains('timeout')) {
      return 'Server is not responding. Please check your internet connection.';
    }
    if (message.contains('SocketException')) {
      return 'Unable to connect to server. Please try again later.';
    }
    return message;
  }

  /// Handle Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;

      // TODO: Implement Google Sign-In logic
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Google Sign-In successful!',
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

  /// Navigate to forgot password screen
  void navigateToForgotPassword() {
    Get.toNamed(AppRoute.getForgotPasswordScreen());
  }

  /// Navigate to create account screen
  void navigateToCreateAccount() {
    Get.toNamed(AppRoute.getSignUpScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
