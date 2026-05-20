import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';

enum FinancialDashboardTab { income, expense, loan }

class FinancialController extends GetxController {
  final FinancialServices _financialServices = FinancialServices();

  final Rx<FinancialDashboardTab> _activeTab = FinancialDashboardTab.income.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSubmitting = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxList<FinancialIncome> _incomes = <FinancialIncome>[].obs;
  final RxList<FinancialExpense> _expenses = <FinancialExpense>[].obs;
  final RxList<FinancialLoan> _loans = <FinancialLoan>[].obs;
  final Rxn<FinancialManagerShowAllResponse> _financialManagerShowAll =
      Rxn<FinancialManagerShowAllResponse>();
  final Rxn<FinancialWealthSummary> _financialWealthSummary =
      Rxn<FinancialWealthSummary>();
  final Rxn<FinancialLoanCalculationResult> _loanCalculationResult =
      Rxn<FinancialLoanCalculationResult>();
  final RxBool _isFinancialManagerShowAllLoading = false.obs;
  final RxBool _isFinancialWealthLoading = false.obs;
  final RxBool _isLoanCalculationLoading = false.obs;
  final Rx<DateTimeRange> _selectedRange = _buildDefaultRange().obs;
  final RxString _financialManagerShowAllMessage = ''.obs;

  FinancialDashboardTab get activeTab => _activeTab.value;
  bool get isLoading => _isLoading.value;
  bool get isSubmitting => _isSubmitting.value;
  String get errorMessage => _errorMessage.value;
  List<FinancialIncome> get incomes => _incomes;
  List<FinancialExpense> get expenses => _expenses;
  List<FinancialLoan> get loans => _loans;
  FinancialManagerShowAllResponse? get financialManagerShowAll =>
      _financialManagerShowAll.value;
  FinancialWealthSummary? get financialWealthSummary =>
      _financialWealthSummary.value;
  FinancialLoanCalculationResult? get loanCalculationResult =>
      _loanCalculationResult.value;
  bool get isFinancialManagerShowAllLoading =>
      _isFinancialManagerShowAllLoading.value;
  String get financialManagerShowAllMessage =>
      _financialManagerShowAllMessage.value;
  bool get isFinancialWealthLoading => _isFinancialWealthLoading.value;
  bool get isLoanCalculationLoading => _isLoanCalculationLoading.value;
  DateTimeRange get selectedRange => _selectedRange.value;
  Stream<List<FinancialIncome>> get incomesStream => _incomes.stream;
  Stream<List<FinancialExpense>> get expensesStream => _expenses.stream;
  Stream<List<FinancialLoan>> get loansStream => _loans.stream;
  Stream<bool> get loadingStream => _isLoading.stream;
  Stream<bool> get submittingStream => _isSubmitting.stream;
  Stream<String> get errorMessageStream => _errorMessage.stream;

  @override
  void onInit() {
    super.onInit();
    fetchIncomes();
    unawaited(fetchFinancialManagerShowAll(showLoader: false));
    unawaited(fetchFinancialWealthSummary(showLoader: false));
  }

  void setActiveTab(FinancialDashboardTab tab) {
    _activeTab.value = tab;
    if (tab == FinancialDashboardTab.income && _incomes.isEmpty && !isLoading) {
      fetchIncomes();
    }
    if (tab == FinancialDashboardTab.expense &&
        _expenses.isEmpty &&
        !isLoading) {
      fetchExpenses();
    }
    if (tab == FinancialDashboardTab.loan && _loans.isEmpty && !isLoading) {
      fetchLoans();
    }
  }

  Future<void> fetchIncomes({
    DateTime? fromDate,
    DateTime? toDate,
    bool showLoader = true,
  }) async {
    if (showLoader) {
      _isLoading.value = true;
    }
    _errorMessage.value = '';

    final range = DateTimeRange(
      start: fromDate ?? _selectedRange.value.start,
      end: toDate ?? _selectedRange.value.end,
    );

    try {
      _selectedRange.value = range;
      final data = await _financialServices.getAllIncomes(
        fromDate: _formatApiDate(range.start),
        toDate: _formatApiDate(range.end),
      );
      data.sort((a, b) {
        final dateComparison = b.date.compareTo(a.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return b.id.compareTo(a.id);
      });
      _incomes.assignAll(data);
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> createIncome({
    required String title,
    required String amountText,
    required DateTime date,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final createdIncome = await _financialServices.createIncome(
        title: cleanedTitle,
        amount: parsedAmount,
        date: _formatApiDate(date),
      );
      _upsertIncome(createdIncome);
      unawaited(fetchIncomes(showLoader: false));
      Get.snackbar(
        'Success',
        'Income added successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> updateIncome({
    required int id,
    required String title,
    required String amountText,
    required DateTime date,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final updatedIncome = await _financialServices.updateIncome(
        id: id,
        title: cleanedTitle,
        amount: parsedAmount,
        date: _formatApiDate(date),
      );
      _upsertIncome(updatedIncome);
      Get.snackbar(
        'Success',
        'Income updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> deleteIncome(int id) async {
    _isSubmitting.value = true;
    try {
      final message = await _financialServices.deleteIncome(id);
      _incomes.removeWhere((item) => item.id == id);
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<FinancialIncome?> getIncomeDetails(int id) async {
    try {
      return await _financialServices.getIncomeById(id);
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> refreshIncomes() async {
    await fetchIncomes(showLoader: false);
  }

  Future<void> fetchExpenses({
    DateTime? fromDate,
    DateTime? toDate,
    bool showLoader = true,
  }) async {
    if (showLoader) {
      _isLoading.value = true;
    }
    _errorMessage.value = '';

    final range = DateTimeRange(
      start: fromDate ?? _selectedRange.value.start,
      end: toDate ?? _selectedRange.value.end,
    );

    try {
      _selectedRange.value = range;
      final data = await _financialServices.getAllExpenses(
        fromDate: _formatApiDate(range.start),
        toDate: _formatApiDate(range.end),
      );
      data.sort((a, b) {
        final dateComparison = b.date.compareTo(a.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return b.id.compareTo(a.id);
      });
      _expenses.assignAll(data);
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> createExpense({
    required String title,
    required String amountText,
    required DateTime date,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final createdExpense = await _financialServices.createExpense(
        title: cleanedTitle,
        amount: parsedAmount,
        date: _formatApiDate(date),
      );
      _upsertExpense(createdExpense);
      unawaited(fetchExpenses(showLoader: false));
      Get.snackbar(
        'Success',
        'Expense added successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> updateExpense({
    required int id,
    required String title,
    required String amountText,
    required DateTime date,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final updatedExpense = await _financialServices.updateExpense(
        id: id,
        title: cleanedTitle,
        amount: parsedAmount,
        date: _formatApiDate(date),
      );
      _upsertExpense(updatedExpense);
      Get.snackbar(
        'Success',
        'Expense updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> deleteExpense(int id) async {
    _isSubmitting.value = true;
    try {
      final message = await _financialServices.deleteExpense(id);
      _expenses.removeWhere((item) => item.id == id);
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<FinancialExpense?> getExpenseDetails(int id) async {
    try {
      return await _financialServices.getExpenseById(id);
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> refreshExpenses() async {
    await fetchExpenses(showLoader: false);
  }

  Future<void> fetchLoans({
    bool showLoader = true,
  }) async {
    if (showLoader) {
      _isLoading.value = true;
    }
    _errorMessage.value = '';

    try {
      final data = await _financialServices.getAllLoans();
      data.sort((a, b) {
        final dateComparison = b.startDate.compareTo(a.startDate);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return b.id.compareTo(a.id);
      });
      _loans.assignAll(data);
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> createLoan({
    required String title,
    required String amountText,
    required String interestRateText,
    required String repaymentPeriodText,
    required DateTime startDate,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());
    final parsedInterestRate = double.tryParse(interestRateText.trim());
    final parsedRepaymentPeriod = int.tryParse(repaymentPeriodText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedInterestRate == null || parsedInterestRate <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid interest rate.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedRepaymentPeriod == null || parsedRepaymentPeriod <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid repayment period.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final createdLoan = await _financialServices.createLoan(
        title: cleanedTitle,
        amount: parsedAmount,
        interestRate: parsedInterestRate,
        repaymentPeriod: parsedRepaymentPeriod,
        startDate: _formatApiDate(startDate),
      );
      _upsertLoan(createdLoan);
      unawaited(fetchLoans(showLoader: false));
      Get.snackbar(
        'Success',
        'Loan added successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> updateLoan({
    required int id,
    required String title,
    required String amountText,
    required String interestRateText,
    required String repaymentPeriodText,
    required DateTime startDate,
  }) async {
    final cleanedTitle = title.trim();
    final parsedAmount = double.tryParse(amountText.trim());
    final parsedInterestRate = double.tryParse(interestRateText.trim());
    final parsedRepaymentPeriod = int.tryParse(repaymentPeriodText.trim());

    if (cleanedTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Title is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedInterestRate == null || parsedInterestRate <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid interest rate.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedRepaymentPeriod == null || parsedRepaymentPeriod <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid repayment period.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isSubmitting.value = true;
    try {
      final updatedLoan = await _financialServices.updateLoan(
        id: id,
        title: cleanedTitle,
        amount: parsedAmount,
        interestRate: parsedInterestRate,
        repaymentPeriod: parsedRepaymentPeriod,
        startDate: _formatApiDate(startDate),
      );
      _upsertLoan(updatedLoan);
      Get.snackbar(
        'Success',
        'Loan updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<bool> deleteLoan(int id) async {
    _isSubmitting.value = true;
    try {
      final message = await _financialServices.deleteLoan(id);
      _loans.removeWhere((item) => item.id == id);
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isSubmitting.value = false;
    }
  }

  Future<FinancialLoan?> getLoanDetails(int id) async {
    try {
      return await _financialServices.getLoanById(id);
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> refreshLoans() async {
    await fetchLoans(showLoader: false);
  }

  Future<void> fetchFinancialManagerShowAll({
    DateTime? fromDate,
    DateTime? toDate,
    bool showLoader = true,
  }) async {
    if (showLoader) {
      _isFinancialManagerShowAllLoading.value = true;
    }
    _errorMessage.value = '';

    final range = DateTimeRange(
      start: fromDate ?? _selectedRange.value.start,
      end: toDate ?? _selectedRange.value.end,
    );

    try {
      _selectedRange.value = range;
      final data = await _financialServices.getFinancialManagerShowAll(
        fromDate: _formatApiDate(range.start),
        toDate: _formatApiDate(range.end),
      );
      _financialManagerShowAll.value = data;
      _financialManagerShowAllMessage.value = data.message.trim();
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      _financialManagerShowAllMessage.value = '';
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isFinancialManagerShowAllLoading.value = false;
    }
  }

  Future<void> fetchFinancialWealthSummary({bool showLoader = true}) async {
    if (showLoader) {
      _isFinancialWealthLoading.value = true;
    }
    _errorMessage.value = '';

    try {
      final data = await _financialServices.getFinancialWealthSummary();
      _financialWealthSummary.value = data;
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isFinancialWealthLoading.value = false;
    }
  }

  Future<bool> calculateFinancialLoan({
    required String amountText,
    required String interestRateText,
    required String repaymentPeriodText,
  }) async {
    final parsedAmount = double.tryParse(amountText.trim());
    final parsedInterestRate = double.tryParse(interestRateText.trim());
    final parsedRepaymentPeriod = int.tryParse(repaymentPeriodText.trim());

    if (parsedAmount == null || parsedAmount <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid loan amount.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedInterestRate == null || parsedInterestRate < 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid interest rate.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (parsedRepaymentPeriod == null || parsedRepaymentPeriod <= 0) {
      Get.snackbar(
        'Validation',
        'Please enter a valid repayment period.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isLoanCalculationLoading.value = true;
    _errorMessage.value = '';
    try {
      final data = await _financialServices.calculateLoan(
        amount: parsedAmount,
        interestRate: parsedInterestRate,
        repaymentPeriod: parsedRepaymentPeriod,
      );
      _loanCalculationResult.value = data;
      return true;
    } catch (e) {
      _errorMessage.value = _cleanMessage(e);
      Get.snackbar(
        'Error',
        _errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoanCalculationLoading.value = false;
    }
  }

  void setSelectedRange(DateTimeRange range) {
    _selectedRange.value = range;
  }

  void _upsertIncome(FinancialIncome item) {
    if (!_isWithinSelectedRange(item.date)) {
      return;
    }
    _incomes.removeWhere((existing) => existing.id == item.id);
    _incomes.add(item);
    _incomes.sort((a, b) {
      final dateComparison = b.date.compareTo(a.date);
      if (dateComparison != 0) {
        return dateComparison;
      }
      return b.id.compareTo(a.id);
    });
  }

  void _upsertExpense(FinancialExpense item) {
    if (!_isWithinSelectedRange(item.date)) {
      return;
    }
    _expenses.removeWhere((existing) => existing.id == item.id);
    _expenses.add(item);
    _expenses.sort((a, b) {
      final dateComparison = b.date.compareTo(a.date);
      if (dateComparison != 0) {
        return dateComparison;
      }
      return b.id.compareTo(a.id);
    });
  }

  void _upsertLoan(FinancialLoan item) {
    _loans.removeWhere((existing) => existing.id == item.id);
    _loans.add(item);
    _loans.sort((a, b) {
      final dateComparison = b.startDate.compareTo(a.startDate);
      if (dateComparison != 0) {
        return dateComparison;
      }
      return b.id.compareTo(a.id);
    });
  }

  bool _isWithinSelectedRange(DateTime value) {
    final start = DateTime(
      _selectedRange.value.start.year,
      _selectedRange.value.start.month,
      _selectedRange.value.start.day,
    );
    final end = DateTime(
      _selectedRange.value.end.year,
      _selectedRange.value.end.month,
      _selectedRange.value.end.day,
    );
    final current = DateTime(value.year, value.month, value.day);
    return !current.isBefore(start) && !current.isAfter(end);
  }

  String _formatApiDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  String _cleanMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }

  static DateTimeRange _buildDefaultRange() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0);
    return DateTimeRange(start: start, end: end);
  }
}
