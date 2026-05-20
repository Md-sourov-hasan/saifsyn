import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/features/stocks/data/model/zoya_stocks_models.dart';
import 'package:saifsyn/features/stocks/data/service/stocks_service.dart';

enum StocksSection { ratings, compliantStocks, etfReports }

class StocksController extends GetxController {
  final StocksService _stocksService = StocksService();
  final TextEditingController symbolTextController =
      TextEditingController(text: 'AMD');

  final RxBool _isLoading = false.obs;
  final RxBool _isCheckingSymbol = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<StocksSection> _activeSection = StocksSection.ratings.obs;

  final Rxn<ZoyaStockReport> _selectedStock = Rxn<ZoyaStockReport>();
  final RxList<ZoyaRatingItem> _ratings = <ZoyaRatingItem>[].obs;
  final RxList<ZoyaCompliantStockItem> _compliantStocks =
      <ZoyaCompliantStockItem>[].obs;
  final RxList<ZoyaEtfReportItem> _etfReports = <ZoyaEtfReportItem>[].obs;

  bool get hasAnyData =>
      _selectedStock.value != null ||
      _ratings.isNotEmpty ||
      _compliantStocks.isNotEmpty ||
      _etfReports.isNotEmpty;
  bool get isLoading => _isLoading.value;
  bool get isCheckingSymbol => _isCheckingSymbol.value;
  String get errorMessage => _errorMessage.value;
  StocksSection get activeSection => _activeSection.value;

  ZoyaStockReport? get selectedStock => _selectedStock.value;
  List<ZoyaRatingItem> get ratings => _ratings;
  List<ZoyaCompliantStockItem> get compliantStocks => _compliantStocks;
  List<ZoyaEtfReportItem> get etfReports => _etfReports;

  int get ratingsCount => _ratings.length;
  int get compliantStocksCount => _compliantStocks.length;
  int get etfCount => _etfReports.length;
  int get compliantRatingsCount =>
      _ratings.where((item) => item.status.toUpperCase() == 'COMPLIANT').length;
  int get compliantEtfCount => _etfReports
      .where((item) => item.status.toUpperCase() == 'COMPLIANT')
      .length;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  @override
  void onClose() {
    symbolTextController.dispose();
    super.onClose();
  }

  Future<void> loadDashboard() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final ratingsFuture = _stocksService.getRatingsForUsMarket();
      final compliantFuture = _stocksService.getCompliantStocks();
      final etfFuture = _stocksService.getEtfReports();

      _ratings.assignAll((await ratingsFuture).items);
      _compliantStocks.assignAll((await compliantFuture).items);
      _etfReports.assignAll((await etfFuture).items);
    } catch (e) {
      _errorMessage.value = _cleanErrorMessage(e);

      AppLoggerHelper.debug("Error showing error message: $_errorMessage");
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  Future<void> searchStockBySymbol() async {
    final symbol = _normalizedSymbol(symbolTextController.text);
    if (symbol.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter a stock symbol.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isCheckingSymbol.value = true;
    symbolTextController.text = symbol;
    try {
      final report = await _stocksService.getSpecificStock(symbol);
      if (report == null) {
        Get.snackbar(
          'No Data',
          'No report found for $symbol.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      _selectedStock.value = report;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isCheckingSymbol.value = false;
    }
  }

  void setActiveSection(StocksSection section) {
    _activeSection.value = section;
  }

  String _normalizedSymbol(String value) {
    return value.trim().toUpperCase();
  }

  String _cleanErrorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
