import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(localizationService),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.11,
                      color: const Color(0xFFF2F4F6),
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'We respect your privacy. This policy explains how your personal data is collected, used, and protected while using this app.\n\n'
                    '1. Information We Collect\n'
                    'We may collect information such as your name, email address, phone number, and app usage data to provide and improve our services.\n\n'
                    '2. How We Use Your Information\n'
                    'Your information is used to create and manage your account, provide core app functionality, improve user experience, and send service-related updates.\n\n'
                    '3. Data Protection\n'
                    'We apply reasonable technical and organizational measures to protect your personal information from unauthorized access or misuse.\n\n'
                    '4. Third-Party Services\n'
                    'Some services may involve trusted third-party providers. We only share required data when necessary to support app features.\n\n'
                    '5. Your Rights\n'
                    'You may request access, correction, or deletion of your personal information where applicable by law.\n\n'
                    '6. Updates to This Policy\n'
                    'This policy may be updated from time to time. Continued use of the app after updates means you accept the revised policy.',
                    style: TextStyle(
                      color: const Color(0xFF354152),
                      fontSize: 16.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(LocalizationService localizationService) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF00008B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  Text(
                    localizationService.translate('back'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              localizationService.translate('privacyPolicy'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please read how we handle your data.',
              style: TextStyle(
                color: const Color(0xD1EDEDED),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
