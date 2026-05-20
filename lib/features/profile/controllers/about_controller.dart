import 'package:get/get.dart';
import 'package:saifsyn/features/profile/data/model/about_response_model.dart';
import 'package:saifsyn/features/profile/data/service/about_service.dart';

class AboutController extends GetxController {
  final AboutService _aboutService = AboutService();

  final RxBool _isLoading = false.obs;
  final Rxn<AboutData> _aboutData = Rxn<AboutData>();

  bool get isLoading => _isLoading.value;
  AboutData? get aboutData => _aboutData.value;

  @override
  void onInit() {
    super.onInit();
    fetchAbout();
  }

  Future<void> fetchAbout() async {
    try {
      _isLoading.value = true;
      final response = await _aboutService.getAbout();
      _aboutData.value = response.data;
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
}
