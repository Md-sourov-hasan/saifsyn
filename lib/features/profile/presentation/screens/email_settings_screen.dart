import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class EmailSettingsScreen extends StatefulWidget {
  const EmailSettingsScreen({super.key});

  @override
  State<EmailSettingsScreen> createState() => _EmailSettingsScreenState();
}

class _EmailSettingsScreenState extends State<EmailSettingsScreen> {
  bool accountActivity = true;
  bool securityAlerts = true;
  bool newsletters = false;
  bool promotions = false;

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
                child: Column(
                  children: [
                    Container(
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
                      child: Column(
                        children: [
                          _settingTile(
                            title: 'Account activity updates',
                            subtitle: 'Receive updates about account actions.',
                            value: accountActivity,
                            onChanged: (value) {
                              setState(() => accountActivity = value);
                            },
                          ),
                          _divider(),
                          _settingTile(
                            title: 'Security alerts',
                            subtitle: 'Get important login and security alerts.',
                            value: securityAlerts,
                            onChanged: (value) {
                              setState(() => securityAlerts = value);
                            },
                          ),
                          _divider(),
                          _settingTile(
                            title: 'Newsletters',
                            subtitle: 'Weekly market and platform news.',
                            value: newsletters,
                            onChanged: (value) {
                              setState(() => newsletters = value);
                            },
                          ),
                          _divider(),
                          _settingTile(
                            title: 'Promotions',
                            subtitle: 'Offers and special campaign emails.',
                            value: promotions,
                            onChanged: (value) {
                              setState(() => promotions = value);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          localizationService.translate('success'),
                          'Email settings saved successfully.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF00008B),
                          colorText: Colors.white,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00008B),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Center(
                          child: Text(
                            'Save Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF1E293B),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: const Color(0xFF697282),
                  fontSize: 12.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF00008B),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        width: double.infinity,
        height: 1,
        color: const Color(0xFFF2F4F6),
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
              localizationService.translate('emailSettings'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose which email notifications you want to receive.',
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
