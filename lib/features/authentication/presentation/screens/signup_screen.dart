import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../controllers/signup_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpController _controller;
  late final String _controllerTag;
  late final LocalizationService _localizationService;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'signup-${DateTime.now().microsecondsSinceEpoch}';
    _controller = Get.put(SignUpController(), tag: _controllerTag);
    _localizationService = Get.find<LocalizationService>();
  }

  @override
  void dispose() {
    if (Get.isRegistered<SignUpController>(tag: _controllerTag)) {
      Get.delete<SignUpController>(tag: _controllerTag, force: true);
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
                  SizedBox(height: 67.h),

                  // Logo
                  _buildLogo(_localizationService),

                  SizedBox(height: 38.h),

                  // Header
                  _buildHeader(_localizationService),

                  SizedBox(height: 20.h),

                  // Name Field
                  CustomTextField(
                    label: _localizationService.translate('nameLabel'),
                    hintText: _localizationService.translate('nameHint'),
                    controller: _controller.nameController,
                    validator: _controller.validateName,
                    keyboardType: TextInputType.name,
                  ),

                  SizedBox(height: 16.h),

                  // Email Field
                  CustomTextField(
                    label: _localizationService.translate('emailLabel'),
                    hintText: _localizationService.translate('emailHintSignUp'),
                    controller: _controller.emailController,
                    validator: _controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 16.h),

                  // Password Field
                  Obx(() => CustomTextField(
                        label: _localizationService.translate('passwordLabel'),
                        hintText: _localizationService
                            .translate('passwordHintSignUp'),
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
                      )),

                  SizedBox(height: 16.h),

                  // Confirm Password Field
                  Obx(() => CustomTextField(
                        label: 'Confirm Password',
                        hintText: 'Re-enter your password',
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

                  SizedBox(height: 16.h),

                  // Role Field
                  Obx(() => _buildRoleField(_controller)),

                  SizedBox(height: 12.h),

                  // Terms Accepted Field
                  _buildTermsField(_controller, _localizationService),

                  SizedBox(height: 16.h),

                  // Sign Up Button
                  Obx(() => PrimaryButton(
                        text: _localizationService.translate('signUpButton'),
                        onPressed: _controller.signUp,
                        isLoading: _controller.isLoading,
                      )),

                  SizedBox(height: 42.h),

                  // // Divider
                  // DividerWithText(
                  //     text: _localizationService.translate('orLoginWith')),

                  // SizedBox(height: 24.h),

                  // // Google Sign-Up Button
                  // GoogleSignInButton(
                  //   onPressed: _controller.signUpWithGoogle,
                  // ),

                  SizedBox(height: 40.h),

                  // Already have account
                  _buildLoginSection(_controller, _localizationService),

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
        ),
      ],
    );
  }

  Widget _buildHeader(LocalizationService localizationService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationService.translate('createAccount'),
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
          localizationService.translate('createAccountFree'),
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

  Widget _buildRoleField(SignUpController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Role',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          value: controller.selectedRole,
          items: const [
            DropdownMenuItem(
              value: 'user',
              child: Text('user'),
            ),
            DropdownMenuItem(
              value: 'admin',
              child: Text('admin'),
            ),
          ],
          onChanged: controller.setRole,
          validator: controller.validateRole,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 4.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color(0xFF00008B),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsField(
    SignUpController controller,
    LocalizationService localizationService,
  ) {
    return FormField<bool>(
      initialValue: controller.termsAccepted,
      validator: controller.validateTermsAccepted,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizationService.translate('termsAndConditions'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() {
              if (controller.isTermsLoading) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE6EAF0)),
                  ),
                  child: const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              final termsContent = controller.localizedTermsContent.trim();
              final errorText = controller.termsErrorMessage.trim();
              if (termsContent.isNotEmpty) {
                return Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxHeight: 140.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE6EAF0)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      termsContent,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF6F6),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFFFD9D9)),
                ),
                child: Text(
                  errorText.isNotEmpty
                      ? errorText
                      : 'Terms and conditions are currently unavailable.',
                  style: TextStyle(
                    color: const Color(0xFFB42318),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              );
            }),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: state.value ?? false,
                  activeColor: const Color(0xFF00008B),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  onChanged: (value) {
                    final checked = value ?? false;
                    state.didChange(checked);
                    controller.setTermsAccepted(checked);
                  },
                ),
                Expanded(
                  child: Text(
                    'I have read and accept the terms and conditions.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLoginSection(
      SignUpController controller, LocalizationService localizationService) {
    return TextButton(
      onPressed: controller.navigateToLogin,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: localizationService.translate('alreadyHaveAccount'),
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: localizationService.translate('loginLink'),
              style: TextStyle(
                color: const Color(0xFF00008B),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
