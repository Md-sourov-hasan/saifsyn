import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final VoidCallback? onUpgradeTap;
  final bool isEliteMember;
  final String? planName;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    this.onUpgradeTap,
    this.isEliteMember = false,
    this.planName,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    final displayPlanName = planName?.trim() ?? '';
    final memberLabel = displayPlanName.isNotEmpty
        ? '$displayPlanName Member'
        : localizationService.translate('eliteMember');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF00008B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 24.h,
          ),
          child: Column(
            children: [
              // Profile avatar
              Container(
                width: 80.w,
                height: 80.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.person,
                        size: 40.sp,
                        color: const Color(0xFF00008B),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 15,
                              offset: Offset(0, 10),
                              spreadRadius: -3,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16.sp,
                          color: const Color(0xFF00008B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Username
              Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 4.h),

              // Email
              Text(
                email,
                style: TextStyle(
                  color: const Color(0xFFD0FAE4),
                  fontSize: 16.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 16.h),

              // Upgrade button or Elite badge
              if (isEliteMember)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDC700),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ImagePath.premiumIcon,
                        width: 32.w,
                        height: 32.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        memberLabel,
                        style: TextStyle(
                          color: const Color(0xFF00008B),
                          fontSize: 16.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              else if (onUpgradeTap != null)
                GestureDetector(
                  onTap: onUpgradeTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Text(
                      localizationService.translate('upgradeToElite'),
                      style: TextStyle(
                        color: const Color(0xFF00008B),
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
