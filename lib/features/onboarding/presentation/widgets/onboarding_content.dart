import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/onboarding_models.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingContent({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),

        // Image/Icon container
        _buildImageContainer(),

        SizedBox(height: 24.h),

        // Title
        _buildTitle(),

        SizedBox(height: 12.h),

        // Description
        _buildDescription(),

        const Spacer(flex: 3),
      ],
    );
  }

  Widget _buildImageContainer() {
    return Container(
      width: 78.w,
      height: 78.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFF00008B),
          ),
          borderRadius: BorderRadius.circular(19.r),
        ),
      ),
      child: Center(
        child: Image.asset(
          page.imagePath,
          width: 50.w,
          height: 50.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Text(
        page.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: 1.20,
          letterSpacing: -0.17,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Text(
        page.description,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFFD0CCCC),
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.20,
          letterSpacing: -0.17,
        ),
      ),
    );
  }
}
