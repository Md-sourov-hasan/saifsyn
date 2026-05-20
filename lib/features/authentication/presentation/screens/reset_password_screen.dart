import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../controllers/reset_password_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final ResetPasswordController _controller;
  late final String _controllerTag;
  late final LocalizationService _localizationService;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'reset-password-${DateTime.now().microsecondsSinceEpoch}';
    _controller = Get.put(ResetPasswordController(), tag: _controllerTag);
    _localizationService = Get.find<LocalizationService>();
  }

  @override
  void dispose() {
    if (Get.isRegistered<ResetPasswordController>(tag: _controllerTag)) {
      Get.delete<ResetPasswordController>(tag: _controllerTag, force: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 67.h),

                  // Logo
                  _buildLogo(_localizationService),

                  SizedBox(height: 50.h),

                  // Title and Description
                  _buildHeader(_localizationService),

                  // New Password Field
                  Obx(() => CustomTextField(
                        label: '',
                        hintText:
                            _localizationService.translate('newPasswordHint'),
                        controller: _controller.newPasswordController,
                        obscureText: !_controller.isNewPasswordVisible,
                        validator: _controller.validateNewPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.isNewPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black.withOpacity(0.5),
                            size: 20.sp,
                          ),
                          onPressed: _controller.toggleNewPasswordVisibility,
                        ),
                      )),

                  SizedBox(height: 10.h),

                  // Password Hint
                  _buildPasswordHint(_controller, _localizationService),

                  SizedBox(height: 15.h),

                  // Confirm Password Field
                  Obx(() => CustomTextField(
                        label: '',
                        hintText: _localizationService
                            .translate('confirmPasswordHint'),
                        controller: _controller.confirmPasswordController,
                        obscureText: !_controller.isConfirmPasswordVisible,
                        validator: _controller.validateConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black.withOpacity(0.5),
                            size: 20.sp,
                          ),
                          onPressed:
                              _controller.toggleConfirmPasswordVisibility,
                        ),
                      )),

                  SizedBox(height: 25.h),

                  // Create Password Button
                  Obx(() => PrimaryButton(
                        text:
                            _localizationService.translate('createNewPassword'),
                        onPressed: _controller.resetPassword,
                        isLoading: _controller.isLoading,
                      )),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(LocalizationService localizationService) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: const Color(0xFF00008B),
              borderRadius: BorderRadius.circular(19.r),
            ),
            child: Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            localizationService.translate('loginScreenTitle'),
            style: TextStyle(
              color: const Color(0xFF111827),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
          Text(
            localizationService.translate('loginScreenTitleAr'),
            style: TextStyle(
              color: const Color(0xFF00008B),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.20,
              letterSpacing: -0.17,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(LocalizationService localizationService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationService.translate('resetPasswordTitle'),
          style: TextStyle(
            color: const Color(0xFF00008B),
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.17,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          localizationService.translate('resetPasswordMessage'),
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.17,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordHint(ResetPasswordController controller,
      LocalizationService localizationService) {
    return Text(
      localizationService.translate('passwordHintText'),
      style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontSize: 12.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
