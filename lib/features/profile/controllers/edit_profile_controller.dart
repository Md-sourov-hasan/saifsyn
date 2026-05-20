import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/profile/controllers/profile_controller.dart';
import 'package:saifsyn/features/profile/data/model/profile_response_model.dart';
import 'package:saifsyn/features/profile/data/service/profile_service.dart';

class EditProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final ProfileController _profileController = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final occupationController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  final _isSaving = false.obs;
  bool get isSaving => _isSaving.value;

  @override
  void onInit() {
    super.onInit();
    _hydrateFromProfile(_profileController.profileData);
  }

  void _hydrateFromProfile(ProfileData? profile) {
    if (profile == null) return;
    fullNameController.text = profile.name;
    emailController.text = profile.email;
    phoneController.text = profile.phone ?? '';
  }

  Future<void> refreshFromServer() async {
    await _profileController.fetchProfile();
    _hydrateFromProfile(_profileController.profileData);
  }

  Future<void> saveChanges() async {
    try {
      _isSaving.value = true;
      final response = await _profileService.updateProfile(
        name: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        dateOfBirth: dobController.text.trim(),
        occupation: occupationController.text.trim(),
        bio: bioController.text.trim(),
      );

      if (response.data != null) {
        _profileController.setProfileData(response.data);
      }

      Get.snackbar(
        'Success',
        response.message.isNotEmpty
            ? response.message
            : 'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isSaving.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    occupationController.dispose();
    addressController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
