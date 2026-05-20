import 'package:get/get.dart';
import 'package:saifsyn/features/analysis/data/model/analysis_response_model.dart';
import 'package:saifsyn/features/analysis/data/service/analysis_service.dart';

enum RiskType { all, low, medium }

class AnalysisController extends GetxController {
  final AnalysisService _analysisService = AnalysisService();

  final RxList<AnalysisItemModel> _stocks = <AnalysisItemModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _searchQuery = ''.obs;
  final selectedRisk = RiskType.all.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get searchQuery => _searchQuery.value;
  List<AnalysisItemModel> get stocks => _stocks;
  List<AnalysisItemModel> get filteredStocks {
    final query = _searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return _stocks;
    }

    return _stocks.where((stock) {
      final name = stock.name.toLowerCase();
      final symbol = stock.symbol.toLowerCase();
      return name.contains(query) || symbol.contains(query);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAnalyses();
  }

  Future<void> fetchAnalyses() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final response = await _analysisService.getAnalyses();
      _stocks.assignAll(response.data);
    } catch (e) {
      _errorMessage.value = _cleanErrorMessage(e);
      if (_stocks.isEmpty) {
        Get.snackbar(
          'Error',
          _errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      _isLoading.value = false;
    }
  }

  void changeRisk(RiskType risk) {
    selectedRisk.value = risk;
  }

  void updateSearchQuery(String value) {
    _searchQuery.value = value;
  }

  String _cleanErrorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
