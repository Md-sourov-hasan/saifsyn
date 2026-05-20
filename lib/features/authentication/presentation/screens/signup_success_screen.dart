import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../../../routes/app_routes.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Scaffold(
      backgroundColor: const Color(0xFF00008B),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 78.w,
                    height: 78.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19.r),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      ImagePath.upwardIcon,
                      color: const Color(0xFF00008B),
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 22.h),

                  // App Name in English
                  Text(
                    localizationService.translate('loginScreenTitle'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                      letterSpacing: -0.17,
                    ),
                  ),

                  SizedBox(height: 9.h),

                  // App Name in Arabic
                  Text(
                    localizationService.translate('loginScreenTitleAr'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFB7B7C6),
                      fontSize: 20.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                      letterSpacing: -0.17,
                    ),
                  ),

                  SizedBox(height: 72.h),

                  // Success Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 41.w),
                    child: Text(
                      localizationService.translate('signUpSuccessTitle'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.20,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // Success Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 61.w),
                    child: Text(
                      localizationService.translate('signUpSuccessMessage'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.80),
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),

                  SizedBox(height: 140.h),

                  // Let's Explore Button
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoute.getMainNavigationScreen());
                    },
                    child: Container(
                      width: 180.w,
                      height: 48.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          localizationService.translate('letsExplore'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF00008B),
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.29,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: const BoxDecoration(
                color: Color(0xFF010196),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                localizationService.translate('poweredBy'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.20,
                  letterSpacing: -0.17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
