import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../controllers/login_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/divider_with_text.dart';
import '../widgets/google_signin_button.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController _controller;
  late final String _controllerTag;
  late final LocalizationService _localizationService;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'login-${DateTime.now().microsecondsSinceEpoch}';
    _controller = Get.put(LoginController(), tag: _controllerTag);
    _localizationService = Get.find<LocalizationService>();
  }

  @override
  void dispose() {
    if (Get.isRegistered<LoginController>(tag: _controllerTag)) {
      Get.delete<LoginController>(tag: _controllerTag, force: true);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h),

                  // Logo
                  _buildLogo(_localizationService),

                  SizedBox(height: 20.h),

                  // Welcome Text
                  _buildWelcomeText(_localizationService),

                  SizedBox(height: 24.h),

                  // Email Field
                  CustomTextField(
                    label: _localizationService.translate('emailLabel'),
                    hintText: _localizationService.translate('emailHint'),
                    controller: _controller.emailController,
                    validator: _controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 16.h),

                  // Password Field
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            label:
                                _localizationService.translate('passwordLabel'),
                            hintText:
                                _localizationService.translate('passwordHint'),
                            controller: _controller.passwordController,
                            obscureText: !_controller.isPasswordVisible,
                            validator: _controller.validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _controller.isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.black.withOpacity(0.5),
                                size: 20.sp,
                              ),
                              onPressed: _controller.togglePasswordVisibility,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _controller.navigateToForgotPassword,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                _localizationService
                                    .translate('forgotPassword'),
                                style: TextStyle(
                                  color: const Color(0xFF00008B),
                                  fontSize: 12.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(0xFF00008B),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),

                  SizedBox(height: 24.h),

                  // Login Button
                  Obx(() => PrimaryButton(
                        text: _localizationService.translate('loginButton'),
                        onPressed: _controller.login,
                        isLoading: _controller.isLoading,
                      )),

                  SizedBox(height: 42.h),

                 

                  SizedBox(height: 24.h),

                  // // Google Sign-In Button
                  // GoogleSignInButton(
                  //   onPressed: _controller.signInWithGoogle,
                  // ),

                  SizedBox(height: 40.h),

                  // Create Account
                  _buildCreateAccountSection(_controller, _localizationService),

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
    return Column(
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
            height: 1.4,
          ),
        ),
        Text(
          localizationService.translate('loginScreenTitleAr'),
          textAlign: TextAlign.center,
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
    );
  }

  Widget _buildWelcomeText(LocalizationService localizationService) {
    return Column(
      children: [
        Text(
          localizationService.translate('welcomeBack'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF00008B),
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          localizationService.translate('loginToDashboard'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 12.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountSection(
      LoginController controller, LocalizationService localizationService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          localizationService.translate('noAccount'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 5.h),
        TextButton(
          onPressed: controller.navigateToCreateAccount,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            localizationService.translate('createAccount'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF00008B),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
