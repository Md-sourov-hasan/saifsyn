import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/profile/data/model/profile_response_model.dart';
import 'package:saifsyn/features/profile/data/service/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();

  final RxBool _isLoading = false.obs;
  final Rxn<ProfileData> _profileData = Rxn<ProfileData>();

  bool get isLoading => _isLoading.value;
  ProfileData? get profileData => _profileData.value;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      _isLoading.value = true;
      final response = await _profileService.getProfile();
      _profileData.value = response.data;
      debugPrint("PROFILE FETCH SUCCESS -> Plan Name: '${response.data?.planName}'");
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void setProfileData(ProfileData? data) {
    _profileData.value = data;
  }
}
