import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/profile/controllers/edit_profile_controller.dart';
import '../widgets/edit_profile_header.dart';
import '../widgets/profile_input_field.dart';
import '../widgets/info_note_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final EditProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(EditProfileController());
    if (_controller.fullNameController.text.isEmpty &&
        _controller.emailController.text.isEmpty &&
        _controller.phoneController.text.isEmpty) {
      _controller.refreshFromServer();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00008B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.dobController.text = '${picked.month}/${picked.day}/${picked.year}';
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _controller.saveChanges();
    }
  }

  void _cancel() {
    Get.back();
  }

  void _changeProfilePhoto() {
    // TODO: Implement image picker for profile photo
    Get.snackbar(
      Get.find<LocalizationService>().translate('changePhotoTitle'),
      Get.find<LocalizationService>().translate('changePhotoMessage'),
      snackPosition: SnackPosition.BOTTOM,
    );
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
                // Header with avatar
                EditProfileHeader(
                  onCameraIconTap: _changeProfilePhoto,
                ),

                SizedBox(height: 43.h),

                // Form fields
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Full Name
                      ProfileInputField(
                        label: localizationService.translate('fullName'),
                        icon: Icons.person_outline,
                        controller: _controller.fullNameController,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: 20.h),

                      // Email Address
                      ProfileInputField(
                        label: localizationService.translate('emailAddress'),
                        icon: Icons.email_outlined,
                        controller: _controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 20.h),

                      // Phone Number
                      ProfileInputField(
                        label: localizationService.translate('phoneNumber'),
                        icon: Icons.phone_outlined,
                        controller: _controller.phoneController,
                        keyboardType: TextInputType.phone,
                      ),

                      SizedBox(height: 20.h),

                      // Date of Birth
                      ProfileInputField(
                        label: localizationService.translate('dateOfBirth'),
                        icon: Icons.calendar_today_outlined,
                        controller: _controller.dobController,
                        hintText: localizationService
                            .translate('selectYourDateOfBirth'),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),

                      SizedBox(height: 20.h),

                      // Occupation
                      ProfileInputField(
                        label: localizationService.translate('occupation'),
                        icon: Icons.work_outline,
                        controller: _controller.occupationController,
                        keyboardType: TextInputType.text,
                      ),

                      SizedBox(height: 20.h),

                      // Address
                      ProfileInputField(
                        label: localizationService.translate('address'),
                        icon: Icons.location_on_outlined,
                        controller: _controller.addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),

                      SizedBox(height: 20.h),

                      // Bio
                      ProfileInputField(
                        label: localizationService.translate('bio'),
                        controller: _controller.bioController,
                        hintText: localizationService
                            .translate('tellUsAboutYourself'),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),

                      SizedBox(height: 32.h),

                      // Save Changes Button
                      GestureDetector(
                        onTap: _saveChanges,
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00008B),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                localizationService.translate('saveChanges'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Cancel Button
                      GestureDetector(
                        onTap: _cancel,
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
                              textAlign: TextAlign.center,
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

                      SizedBox(height: 24.h),

                      // Info note
                      InfoNoteCard(
                        title: localizationService.translate('note'),
                        message:
                            localizationService.translate('infoNoteMessage'),
                      ),

                      SizedBox(height: 40.h),
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
}
