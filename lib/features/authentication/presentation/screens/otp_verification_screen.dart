import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../controllers/otp_verification_controller.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/primary_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final OtpVerificationController _controller;
  late final String _controllerTag;
  late final LocalizationService _localizationService;

  @override
  void initState() {
    super.initState();
    _controllerTag = 'otp-${DateTime.now().microsecondsSinceEpoch}';
    _controller = Get.put(OtpVerificationController(), tag: _controllerTag);
    _localizationService = Get.find<LocalizationService>();
  }

  @override
  void dispose() {
    if (Get.isRegistered<OtpVerificationController>(tag: _controllerTag)) {
      Get.delete<OtpVerificationController>(tag: _controllerTag, force: true);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 67.h),

                // Logo
                _buildLogo(_localizationService),

                SizedBox(height: 90.h),

                // Title and Description
                _buildHeader(_controller, _localizationService),

                SizedBox(height: 40.h),

                // OTP Input Fields
                _buildOtpFields(_controller),

                SizedBox(height: 30.h),

                // Resend Code
                _buildResendSection(_controller, _localizationService),

                SizedBox(height: 40.h),

                // Verify Button
                Obx(() => PrimaryButton(
                      text: _localizationService.translate('verify'),
                      onPressed: _controller.verifyOtp,
                      isLoading: _controller.isLoading,
                    )),

                SizedBox(height: 20.h),
              ],
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

  Widget _buildHeader(OtpVerificationController controller,
      LocalizationService localizationService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationService.translate('otpVerificationTitle'),
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
          localizationService.translate('otpVerificationMessage'),
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

  Widget _buildOtpFields(OtpVerificationController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) => OtpInputField(
          controller: controller.otpControllers[index],
          focusNode: controller.focusNodes[index],
          onChanged: (value) => controller.onOtpChanged(index, value),
        ),
      ),
    );
  }

  Widget _buildResendSection(OtpVerificationController controller,
      LocalizationService localizationService) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizationService.translate('resend'),
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.w),
          if (!controller.canResend)
            Text(
              '( ${controller.formattedTimer} )',
              style: TextStyle(
                color: const Color(0xFF00008B),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            )
          else
            TextButton(
              onPressed: controller.resendOtp,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                localizationService.translate('tapToResend'),
                style: TextStyle(
                  color: const Color(0xFF00008B),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF00008B),
                ),
              ),
            ),
        ],
      );
    });
  }
}
