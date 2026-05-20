import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/profile/data/service/contact_service.dart';

class ContactController extends GetxController {
  final ContactService _contactService = ContactService();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? validateRequired(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<String> submitContact() async {
    final firstNameError = validateRequired(firstNameController.text, 'First name');
    if (firstNameError != null) throw Exception(firstNameError);

    final lastNameError = validateRequired(lastNameController.text, 'Last name');
    if (lastNameError != null) throw Exception(lastNameError);

    final emailError = validateEmail(emailController.text);
    if (emailError != null) throw Exception(emailError);

    final phoneError = validateRequired(phoneController.text, 'Phone number');
    if (phoneError != null) throw Exception(phoneError);

    final messageError = validateRequired(messageController.text, 'Message');
    if (messageError != null) throw Exception(messageError);

    _isLoading.value = true;
    try {
      final response = await _contactService.sendContactMessage(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        message: messageController.text.trim(),
      );
      return response.message.isNotEmpty
          ? response.message
          : 'Your message has been sent successfully';
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
