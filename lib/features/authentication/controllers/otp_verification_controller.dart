import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/authentication/data/service/otp_verification_service.dart';
import '../../../routes/app_routes.dart';

class OtpVerificationController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(5, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  final _isLoading = false.obs;
  final _resendTimer = 60.obs;
  final _canResend = false.obs;

  bool get isLoading => _isLoading.value;
  int get resendTimer => _resendTimer.value;
  bool get canResend => _canResend.value;

  Timer? _timer;

  String email = '';
  String purpose = 'signup';

  final OtpVerificationService _otpVerificationService = OtpVerificationService();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is String) {
      email = args;
    } else if (args is Map<String, dynamic>) {
      email = args['email']?.toString() ?? '';
      purpose = args['purpose']?.toString() ?? 'signup';
    }
    startResendTimer();
  }

  void startResendTimer() {
    _resendTimer.value = 60;
    _canResend.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer.value > 0) {
        _resendTimer.value--;
      } else {
        _canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get formattedTimer {
    final minutes = _resendTimer.value ~/ 60;
    final seconds = _resendTimer.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getCurrentOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    final otp = getCurrentOtp();

    if (email.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required for OTP verification',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    if (otp.length != 5) {
      Get.snackbar(
        'Error',
        'Please enter complete verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      _isLoading.value = true;

      final response = await _otpVerificationService.verifyOtp(
        email: email.trim(),
        otp: otp,
      );

      Get.snackbar(
        'Success',
        response.message.isNotEmpty
            ? response.message
            : 'Verification successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      if (purpose == 'forgot_password') {
        Get.toNamed(
          AppRoute.getResetPasswordScreen(),
          arguments: {'email': email},
        );
      } else {
        Get.offAllNamed(AppRoute.getLoginScreen());
      }
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

  Future<void> resendOtp() async {
    if (!_canResend.value) return;

    try {
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Success',
        'Verification code sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );

      for (final controller in otpControllers) {
        controller.clear();
      }

      focusNodes[0].requestFocus();
      startResendTimer();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 4) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    if (index == 4 && value.isNotEmpty) {
      final otp = getCurrentOtp();
      if (otp.length == 5) {
        FocusScope.of(Get.context!).unfocus();
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
