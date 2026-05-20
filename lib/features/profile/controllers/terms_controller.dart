import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/profile/data/model/terms_response_model.dart';
import 'package:saifsyn/features/profile/data/service/terms_service.dart';

class TermsController extends GetxController {
  final TermsService _termsService = TermsService();

  final RxBool _isLoading = false.obs;
  final Rxn<TermsData> _termsData = Rxn<TermsData>();

  bool get isLoading => _isLoading.value;
  TermsData? get termsData => _termsData.value;

  String get localizedContent {
    final content = _termsData.value?.content;
    if (content == null) return '';
    final languageCode = Get.find<LocalizationService>().locale.languageCode;
    if (languageCode == 'bn') {
      return content.bn.isNotEmpty ? content.bn : content.en;
    }
    return content.en.isNotEmpty ? content.en : content.bn;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTerms();
  }

  Future<void> fetchTerms() async {
    try {
      _isLoading.value = true;
      final response = await _termsService.getTerms();
      _termsData.value = response.data;
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
