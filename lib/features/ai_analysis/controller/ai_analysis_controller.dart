import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/ai_analysis/data/model/ai_company_analysis_models.dart';
import 'package:saifsyn/features/ai_analysis/data/service/ai_company_analysis_service.dart';

enum RiskType { all, low, medium }

enum AnalysisLanguage { english, arabic }

class AnalysisController extends GetxController {
  AnalysisController({CompanyAnalysisService? service})
      : _service = service ?? CompanyAnalysisService();

  final CompanyAnalysisService _service;
  final TextEditingController searchController = TextEditingController();
  final ScrollController contentScrollController = ScrollController();

  final RxDouble floatingHeightFactor = 1.0.obs;
  double _lastOffset = 0.0;
  final double _headerScrollDistance = 150.0;

  final RxBool _isBootstrapping = true.obs;
  final RxBool _isSearching = false.obs;
  final RxBool _isHistoryLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rxn<CompanyAnalysisResult> _selectedResult =
      Rxn<CompanyAnalysisResult>();
  final RxList<AnalysisHistoryItem> _history = <AnalysisHistoryItem>[].obs;
  final RxString _selectedHistoryId = ''.obs;
  final Rx<AnalysisLanguage> _language = AnalysisLanguage.english.obs;
  final selectedRisk = RiskType.all.obs;

  bool get isBootstrapping => _isBootstrapping.value;
  bool get isSearching => _isSearching.value;
  bool get isHistoryLoading => _isHistoryLoading.value;
  bool get isBusy => isBootstrapping || isSearching || isHistoryLoading;
  String get errorMessage => _errorMessage.value;
  CompanyAnalysisResult? get selectedResult => _selectedResult.value;
  List<AnalysisHistoryItem> get history => _history;
  String get selectedHistoryId => _selectedHistoryId.value;
  AnalysisLanguage get language => _language.value;
  bool get hasResult => _selectedResult.value != null;

  String get languageLabel =>
      language == AnalysisLanguage.english ? 'English' : 'Arabic';

  String get query => searchController.text.trim();

  @override
  void onInit() {
    super.onInit();
    _language.value = _resolveInitialLanguage();
    _initScrollListener();
    bootstrap();
  }

  void _initScrollListener() {
    contentScrollController.addListener(() {
      final double currentOffset = contentScrollController.offset;
      final double delta = currentOffset - _lastOffset;

      if (currentOffset <= 0) {
        floatingHeightFactor.value = 1.0;
      } else {
        double currentFactor = floatingHeightFactor.value;
        currentFactor -= delta / _headerScrollDistance;
        currentFactor = currentFactor.clamp(0.0, 1.0);
        if (floatingHeightFactor.value != currentFactor) {
          floatingHeightFactor.value = currentFactor;
        }
      }

      _lastOffset = currentOffset;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    contentScrollController.dispose();
    super.onClose();
  }

  Future<void> bootstrap() async {
    _isBootstrapping.value = true;
    _errorMessage.value = '';

    try {
      await fetchHistory(preloadLatest: true);
    } catch (error) {
      _errorMessage.value = _cleanError(error);
    } finally {
      _isBootstrapping.value = false;
    }
  }

  Future<void> fetchHistory({bool preloadLatest = false}) async {
    _isHistoryLoading.value = true;

    try {
      final items = await _service.getHistory(_userId);
      _history.assignAll(items);

      if (preloadLatest && items.isNotEmpty) {
        await openHistoryItem(items.first);
      }
    } finally {
      _isHistoryLoading.value = false;
    }
  }

  Future<void> analyze() async {
    final companyName = query;
    if (companyName.isEmpty) {
      _errorMessage.value = 'Please enter a company name.';
      Get.snackbar(
        'Company required',
        'Enter a company name to run analysis.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isSearching.value = true;
    _errorMessage.value = '';

    try {
      final result = await _service.analyzeCompany(
        userId: _userId,
        planId: _planId,
        companyName: companyName,
        language: _apiLanguage,
      );

      _selectedResult.value = result;
      _selectedHistoryId.value = '';
      await fetchHistory();
      _primeSearchField(
        result.companyName.isNotEmpty ? result.companyName : companyName,
      );
      _scrollToTop();
    } catch (error) {
      _errorMessage.value = _cleanError(error);
      Get.snackbar(
        'Analysis failed',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSearching.value = false;
    }
  }

  Future<void> openHistoryItem(AnalysisHistoryItem item) async {
    if (item.id.isEmpty) return;

    _errorMessage.value = '';
    _selectedHistoryId.value = item.id;
    _primeSearchField(item.companyName);

    try {
      final result = await _service.getResult(item.id);
      _selectedResult.value = result;
      _syncLanguageFromHistory(item.language);
      _scrollToTop();
    } catch (error) {
      _errorMessage.value = _cleanError(error);
      Get.snackbar(
        'Unable to load result',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> refreshCurrent() async {
    if (selectedHistoryId.isNotEmpty) {
      AnalysisHistoryItem? item;
      for (final entry in _history) {
        if (entry.id == selectedHistoryId) {
          item = entry;
          break;
        }
      }
      if (item != null) {
        await openHistoryItem(item);
        return;
      }
    }
    await fetchHistory(preloadLatest: selectedResult == null);
  }

  void updateLanguage(AnalysisLanguage nextLanguage) {
    _language.value = nextLanguage;
  }

  void changeRisk(RiskType risk) {
    selectedRisk.value = risk;
  }

  void clearError() {
    _errorMessage.value = '';
  }

  void _primeSearchField(String value) {
    searchController
      ..text = value
      ..selection = TextSelection.collapsed(offset: value.length);
  }

  void _syncLanguageFromHistory(String languageValue) {
    final normalized = languageValue.trim().toLowerCase();
    _language.value = normalized == 'arabic'
        ? AnalysisLanguage.arabic
        : AnalysisLanguage.english;
  }

  AnalysisLanguage _resolveInitialLanguage() {
    if (Get.isRegistered<LocalizationService>()) {
      final code = Get.find<LocalizationService>().locale.languageCode;
      if (code.toLowerCase().startsWith('ar')) {
        return AnalysisLanguage.arabic;
      }
    }
    return AnalysisLanguage.english;
  }

  void _scrollToTop() {
    if (!contentScrollController.hasClients) return;
    contentScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  String get _userId => StorageService.userId?.trim().isNotEmpty == true
      ? StorageService.userId!.trim()
      : '2';

  int get _planId => 2;

  String get _apiLanguage =>
      language == AnalysisLanguage.english ? 'english' : 'arabic';

  String _cleanError(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
