import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/profile/controllers/change_password_controller.dart';
import '../widgets/change_password_header.dart';
import '../widgets/password_input_field.dart';
import '../widgets/password_requirements_card.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ChangePasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ChangePasswordController());
  }

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      final localizationService = Get.find<LocalizationService>();
      try {
        final successMessage = await _controller.changePassword();

        Get.dialog(
          AlertDialog(
            title: Text(localizationService.translate('success')),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(localizationService.translate('ok')),
              ),
            ],
          ),
        );
      } catch (e) {
        Get.snackbar(
          localizationService.translate('error'),
          e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void _cancel() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                const ChangePasswordHeader(),

                SizedBox(height: 22.h),

                // Form fields
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      // Current Password
                      PasswordInputField(
                        label: localizationService
                            .translate('currentPasswordLabel'),
                        hintText: localizationService
                            .translate('currentPasswordHint'),
                        controller: _controller.currentPasswordController,
                        validator: _controller.validateCurrentPassword,
                      ),

                      SizedBox(height: 20.h),

                      // New Password
                      PasswordInputField(
                        label:
                            localizationService.translate('newPasswordLabel'),
                        hintText:
                            localizationService.translate('newPasswordHint'),
                        controller: _controller.newPasswordController,
                        validator: _controller.validateNewPassword,
                        helperText:
                            localizationService.translate('passwordMin8'),
                      ),

                      SizedBox(height: 20.h),

                      // Confirm New Password
                      PasswordInputField(
                        label: localizationService
                            .translate('confirmPasswordLabel'),
                        hintText: localizationService
                            .translate('confirmPasswordHint'),
                        controller: _controller.confirmPasswordController,
                        validator: _controller.validateConfirmPassword,
                      ),

                      SizedBox(height: 32.h),

                      // Password requirements card
                      const PasswordRequirementsCard(),

                      SizedBox(height: 36.h),

                      // Update Password Button
                      GestureDetector(
                        onTap: _updatePassword,
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00008B),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                localizationService.translate('updatePassword'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Cancel Button
                      GestureDetector(
                        onTap: _cancel,
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Center(
                            child: Text(
                              localizationService.translate('cancel'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF354152),
                                fontSize: 16.sp,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
