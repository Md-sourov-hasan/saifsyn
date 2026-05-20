import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../controllers/forgot_password_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordController _controller;
  late final String _controllerTag;
  late final LocalizationService _localizationService;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'forgot-password-${DateTime.now().microsecondsSinceEpoch}';
    _controller = Get.put(ForgotPasswordController(), tag: _controllerTag);
    _localizationService = Get.find<LocalizationService>();
  }

  @override
  void dispose() {
    if (Get.isRegistered<ForgotPasswordController>(tag: _controllerTag)) {
      Get.delete<ForgotPasswordController>(tag: _controllerTag, force: true);
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
                  SizedBox(height: 60.h),

                  // Logo
                  _buildLogo(_localizationService),

                  SizedBox(height: 20.h),

                  // Title and Description
                  _buildHeader(_localizationService),

                  SizedBox(height: 20.h),

                  // Email Field
                  CustomTextField(
                    label: '',
                    hintText:
                        _localizationService.translate('forgotPasswordHint'),
                    controller: _controller.emailController,
                    validator: _controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 25.h),

                  // Request Code Button
                  Obx(() => PrimaryButton(
                        text: _localizationService.translate('requestCode'),
                        onPressed: _controller.requestResetCode,
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
          localizationService.translate('forgotPasswordTitle'),
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
          localizationService.translate('forgotPasswordMessage'),
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
}
