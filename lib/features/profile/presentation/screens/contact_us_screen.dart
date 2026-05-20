import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/profile/controllers/contact_controller.dart';
import 'package:saifsyn/features/profile/presentation/widgets/profile_input_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ContactController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ContactController());
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final message = await _controller.submitContact();
      Get.closeAllSnackbars();
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) {
        Get.back();
      }
    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(localizationService),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      ProfileInputField(
                        label: 'First Name',
                        icon: Icons.person_outline,
                        controller: _controller.firstNameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 16.h),
                      ProfileInputField(
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        controller: _controller.lastNameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 16.h),
                      ProfileInputField(
                        label: localizationService.translate('emailAddress'),
                        icon: Icons.email_outlined,
                        controller: _controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.h),
                      ProfileInputField(
                        label: localizationService.translate('phoneNumber'),
                        icon: Icons.phone_outlined,
                        controller: _controller.phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.h),
                      ProfileInputField(
                        label: 'Message',
                        icon: Icons.message_outlined,
                        controller: _controller.messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      SizedBox(height: 28.h),
                      GestureDetector(
                        onTap: _submit,
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00008B),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Center(
                            child: Obx(
                              () => _controller.isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Send Message',
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
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Center(
                            child: Text(
                              localizationService.translate('cancel'),
                              style: TextStyle(
                                color: const Color(0xFF354152),
                                fontSize: 16.sp,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              localizationService.translate('ContactUs'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tell us how we can help you. We will get back to you soon.',
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
