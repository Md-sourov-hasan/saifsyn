import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';

class FinancialServices {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<FinancialIncome> createIncome({
    required String title,
    required num amount,
    required String date,
  }) async {
    final response = await _networkCaller.postRequest(
      ApiConstants.financialIncomes,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'date': date,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final data = response.responseData as Map<String, dynamic>;
      final incomeJson = data['income'];
      if (incomeJson is Map<String, dynamic>) {
        return FinancialIncome.fromJson(incomeJson);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to create income'),
    );
  }

  Future<List<FinancialIncome>> getAllIncomes({
    required String fromDate,
    required String toDate,
  }) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialIncomes,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      queryParams: {
        'from_date': fromDate,
        'to_date': toDate,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final data = response.responseData as Map<String, dynamic>;
      final list = data['data'];
      if (list is List) {
        return list
            .whereType<Map<String, dynamic>>()
            .map(FinancialIncome.fromJson)
            .toList();
      }
      return <FinancialIncome>[];
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load incomes'),
    );
  }

  Future<FinancialIncome> getIncomeById(int id) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialIncomeById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return FinancialIncome.fromJson(response.responseData);
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load income details'),
    );
  }

  Future<FinancialIncome> updateIncome({
    required int id,
    required String title,
    required num amount,
    required String date,
  }) async {
    final response = await _networkCaller.putRequest(
      ApiConstants.financialIncomeById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'date': date,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final data = response.responseData as Map<String, dynamic>;
      final incomeJson = data['income'];
      if (incomeJson is Map<String, dynamic>) {
        return FinancialIncome.fromJson(incomeJson);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to update income'),
    );
  }

  Future<String> deleteIncome(int id) async {
    final response = await _networkCaller.deleteRequest(
      ApiConstants.financialIncomeById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final data = response.responseData;
      if (data is Map<String, dynamic>) {
        final message = data['message']?.toString() ?? '';
        return message.ifEmpty('Income deleted successfully');
      }
      return 'Income deleted successfully';
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to delete income'),
    );
  }

  Future<FinancialExpense> createExpense({
    required String title,
    required num amount,
    required String date,
  }) async {
    final response = await _networkCaller.postRequest(
      ApiConstants.financialExpenses,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'date': date,
      },
    );

    if (response.isSuccess) {
      final json = _extractEntityMap(response.responseData, key: 'expense');
      if (json != null) {
        return FinancialExpense.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to create expense'),
    );
  }

  Future<List<FinancialExpense>> getAllExpenses({
    required String fromDate,
    required String toDate,
  }) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialExpenses,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      queryParams: {
        'from_date': fromDate,
        'to_date': toDate,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final data = response.responseData as Map<String, dynamic>;
      final list = data['data'];
      if (list is List) {
        return list
            .whereType<Map<String, dynamic>>()
            .map(FinancialExpense.fromJson)
            .toList();
      }
      return <FinancialExpense>[];
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load expenses'),
    );
  }

  Future<FinancialExpense> getExpenseById(int id) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialExpenseById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final json = _extractEntityMap(response.responseData, key: 'expense');
      if (json != null) {
        return FinancialExpense.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load expense details'),
    );
  }

  Future<FinancialExpense> updateExpense({
    required int id,
    required String title,
    required num amount,
    required String date,
  }) async {
    final response = await _networkCaller.putRequest(
      ApiConstants.financialExpenseById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'date': date,
      },
    );

    if (response.isSuccess) {
      final json = _extractEntityMap(response.responseData, key: 'expense');
      if (json != null) {
        return FinancialExpense.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to update expense'),
    );
  }

  Future<String> deleteExpense(int id) async {
    final response = await _networkCaller.deleteRequest(
      ApiConstants.financialExpenseById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final data = response.responseData;
      if (data is Map<String, dynamic>) {
        final message = data['message']?.toString() ?? '';
        return message.ifEmpty('Expense deleted successfully');
      }
      return 'Expense deleted successfully';
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to delete expense'),
    );
  }

  Future<FinancialLoan> createLoan({
    required String title,
    required num amount,
    required num interestRate,
    required int repaymentPeriod,
    required String startDate,
  }) async {
    final response = await _networkCaller.postRequest(
      ApiConstants.financialLoans,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'interest_rate': interestRate,
        'repayment_period': repaymentPeriod,
        'start_date': startDate,
      },
    );

    if (response.isSuccess) {
      final json = _extractLoanMap(response.responseData);
      if (json != null) {
        return FinancialLoan.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to create loan'),
    );
  }

  Future<List<FinancialLoan>> getAllLoans() async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialLoans,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final data = response.responseData;

      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(FinancialLoan.fromJson)
            .toList();
      }

      if (data is Map<String, dynamic>) {
        final dynamic list = data['data'] ?? data['loans'];
        if (list is List) {
          return list
              .whereType<Map<String, dynamic>>()
              .map(FinancialLoan.fromJson)
              .toList();
        }

        final single = data['loan'] ?? data['data'];
        if (single is Map<String, dynamic>) {
          return [FinancialLoan.fromJson(single)];
        }
      }

      return <FinancialLoan>[];
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load loans'),
    );
  }

  Future<FinancialLoan> getLoanById(int id) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialLoanById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final json = _extractLoanMap(response.responseData);
      if (json != null) {
        return FinancialLoan.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load loan details'),
    );
  }

  Future<FinancialLoan> updateLoan({
    required int id,
    required String title,
    required num amount,
    required num interestRate,
    required int repaymentPeriod,
    required String startDate,
  }) async {
    final response = await _networkCaller.putRequest(
      ApiConstants.financialLoanById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'title': title,
        'amount': amount,
        'interest_rate': interestRate,
        'repayment_period': repaymentPeriod,
        'start_date': startDate,
      },
    );

    if (response.isSuccess) {
      final json = _extractLoanMap(response.responseData);
      if (json != null) {
        return FinancialLoan.fromJson(json);
      }
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to update loan'),
    );
  }

  Future<String> deleteLoan(int id) async {
    final response = await _networkCaller.deleteRequest(
      ApiConstants.financialLoanById(id),
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess) {
      final data = response.responseData;
      if (data is Map<String, dynamic>) {
        final message = data['message']?.toString() ?? '';
        return message.ifEmpty('Loan deleted successfully');
      }
      return 'Loan deleted successfully';
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to delete loan'),
    );
  }

  Future<FinancialManagerShowAllResponse> getFinancialManagerShowAll({
    required String fromDate,
    required String toDate,
  }) async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialManagerShowAll,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      queryParams: {
        'from_date': fromDate,
        'to_date': toDate,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return FinancialManagerShowAllResponse.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load financial manager data'),
    );
  }

  Future<FinancialWealthSummary> getFinancialWealthSummary() async {
    final response = await _networkCaller.getRequest(
      ApiConstants.financialWealth,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return FinancialWealthSummary.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to load wealth data'),
    );
  }

  Future<FinancialLoanCalculationResult> calculateLoan({
    required num amount,
    required num interestRate,
    required int repaymentPeriod,
  }) async {
    final response = await _networkCaller.postRequest(
      ApiConstants.financialLoanCalculation,
      token: _bearerToken,
      headers: const {'Accept': 'application/json'},
      body: {
        'amount': amount,
        'interest_rate': interestRate,
        'repayment_period': repaymentPeriod,
      },
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      return FinancialLoanCalculationResult.fromJson(
        response.responseData as Map<String, dynamic>,
      );
    }

    throw Exception(
      _extractErrorMessage(response.responseData, response.errorMessage)
          .ifEmpty('Failed to calculate loan'),
    );
  }

  String get _bearerToken {
    final rawToken = StorageService.token?.trim() ?? '';
    if (rawToken.isEmpty) {
      throw Exception('Login required. Token not found.');
    }
    return rawToken.toLowerCase().startsWith('bearer ')
        ? rawToken
        : 'Bearer $rawToken';
  }

  String _extractErrorMessage(dynamic responseData, String fallback) {
    if (fallback.trim().isNotEmpty) {
      return fallback.trim();
    }
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message']?.toString();
      if (message != null && message.trim().isNotEmpty) {
        return message.trim();
      }
    }
    if (responseData is String && responseData.trim().isNotEmpty) {
      return responseData.trim();
    }
    return '';
  }

  Map<String, dynamic>? _extractEntityMap(
    dynamic responseData, {
    required String key,
  }) {
    if (responseData is Map<String, dynamic>) {
      final nested = responseData[key];
      if (nested is Map<String, dynamic>) {
        return nested;
      }
      return responseData;
    }
    return null;
  }

  Map<String, dynamic>? _extractNestedMap(
    dynamic responseData, {
    required String key,
  }) {
    if (responseData is Map<String, dynamic>) {
      final nested = responseData[key];
      if (nested is Map<String, dynamic>) {
        return nested;
      }
    }
    return null;
  }

  Map<String, dynamic>? _extractLoanMap(dynamic responseData) {
    final fromLoan = _extractNestedMap(responseData, key: 'loan');
    if (fromLoan != null) {
      return fromLoan;
    }

    final fromData = _extractNestedMap(responseData, key: 'data');
    if (fromData != null) {
      return fromData;
    }

    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('id') &&
        responseData.containsKey('title')) {
      return responseData;
    }

    return null;
  }
}

class FinancialIncome {
  final int id;
  final int? userId;
  final String title;
  final double amount;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FinancialIncome({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FinancialIncome.fromJson(Map<String, dynamic> json) {
    return FinancialIncome(
      id: _toInt(json['id']),
      userId: _toNullableInt(json['user_id']),
      title: json['title']?.toString() ?? '',
      amount: _toDouble(json['amount']),
      date: _toDate(json['date']),
      createdAt: _toNullableDate(json['created_at']),
      updatedAt: _toNullableDate(json['updated_at']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _toNullableInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime _toDate(dynamic value) {
    final parsed = DateTime.tryParse(value?.toString() ?? '');
    return parsed ?? DateTime.now();
  }

  static DateTime? _toNullableDate(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }
}

class FinancialExpense {
  final int id;
  final int? userId;
  final String title;
  final double amount;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FinancialExpense({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FinancialExpense.fromJson(Map<String, dynamic> json) {
    return FinancialExpense(
      id: FinancialIncome._toInt(json['id']),
      userId: FinancialIncome._toNullableInt(json['user_id']),
      title: json['title']?.toString() ?? '',
      amount: FinancialIncome._toDouble(json['amount']),
      date: FinancialIncome._toDate(json['date']),
      createdAt: FinancialIncome._toNullableDate(json['created_at']),
      updatedAt: FinancialIncome._toNullableDate(json['updated_at']),
    );
  }
}

class FinancialLoan {
  final int id;
  final int? userId;
  final String title;
  final double amount;
  final double interestRate;
  final int repaymentPeriod;
  final DateTime startDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FinancialLoan({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.interestRate,
    required this.repaymentPeriod,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FinancialLoan.fromJson(Map<String, dynamic> json) {
    return FinancialLoan(
      id: FinancialIncome._toInt(json['id']),
      userId: FinancialIncome._toNullableInt(json['user_id']),
      title: json['title']?.toString() ?? '',
      amount: FinancialIncome._toDouble(json['amount']),
      interestRate: FinancialIncome._toDouble(json['interest_rate']),
      repaymentPeriod: FinancialIncome._toInt(json['repayment_period']),
      startDate: FinancialIncome._toDate(json['start_date']),
      createdAt: FinancialIncome._toNullableDate(json['created_at']),
      updatedAt: FinancialIncome._toNullableDate(json['updated_at']),
    );
  }
}

class FinancialManagerShowAllResponse {
  final bool success;
  final bool hasData;
  final String message;
  final double totalIncome;
  final double totalExpense;
  final double totalLoan;
  final double netBalance;
  final String balanceStatus;
  final List<FinancialSummaryItem> incomes;
  final List<FinancialSummaryItem> expenses;
  final List<FinancialSummaryItem> loans;
  final FinancialAiInsights? aiInsights;

  const FinancialManagerShowAllResponse({
    required this.success,
    required this.hasData,
    required this.message,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalLoan,
    required this.netBalance,
    required this.balanceStatus,
    required this.incomes,
    required this.expenses,
    required this.loans,
    required this.aiInsights,
  });

  factory FinancialManagerShowAllResponse.fromJson(Map<String, dynamic> json) {
    List<FinancialSummaryItem> parseList(dynamic value) {
      if (value is List) {
        return value
            .whereType<Map<String, dynamic>>()
            .map(FinancialSummaryItem.fromJson)
            .toList();
      }
      return <FinancialSummaryItem>[];
    }

    final success = json['success'] == true;
    final message = json['message']?.toString() ?? '';
    final rawData = json['data'];
    final hasWrappedDataKey = json.containsKey('data');
    final hasData = rawData is Map<String, dynamic>;
    final source =
        hasData ? rawData : (hasWrappedDataKey ? <String, dynamic>{} : json);
    final aiJson = source['ai_insights'];

    return FinancialManagerShowAllResponse(
      success: success,
      hasData: hasWrappedDataKey ? hasData : success,
      message: message,
      totalIncome: FinancialIncome._toDouble(source['totalIncome']),
      totalExpense: FinancialIncome._toDouble(source['totalExpense']),
      totalLoan: FinancialIncome._toDouble(source['totalLoan']),
      netBalance: FinancialIncome._toDouble(source['netBalance']),
      balanceStatus: source['balanceStatus']?.toString() ?? '',
      incomes: parseList(source['incomes']),
      expenses: parseList(source['expenses']),
      loans: parseList(source['loans']),
      aiInsights: aiJson is Map<String, dynamic>
          ? FinancialAiInsights.fromJson(aiJson)
          : null,
    );
  }
}

class FinancialSummaryItem {
  final double amount;
  final DateTime date;

  const FinancialSummaryItem({
    required this.amount,
    required this.date,
  });

  factory FinancialSummaryItem.fromJson(Map<String, dynamic> json) {
    return FinancialSummaryItem(
      amount: FinancialIncome._toDouble(json['amount']),
      date: FinancialIncome._toDate(json['date'] ?? json['start_date']),
    );
  }
}

class FinancialAiInsights {
  final int score;
  final double savings;
  final double savingsPercent;
  final List<String> insights;

  const FinancialAiInsights({
    required this.score,
    required this.savings,
    required this.savingsPercent,
    required this.insights,
  });

  factory FinancialAiInsights.fromJson(Map<String, dynamic> json) {
    final rawInsights = json['insights'];
    return FinancialAiInsights(
      score: FinancialIncome._toInt(json['score']),
      savings: FinancialIncome._toDouble(json['savings']),
      savingsPercent: FinancialIncome._toDouble(json['savingsPercent']),
      insights: rawInsights is List
          ? rawInsights.map((item) => item.toString()).toList()
          : <String>[],
    );
  }
}

class FinancialWealthSummary {
  final bool success;
  final double totalIncome;
  final double totalExpense;
  final double totalLoan;
  final double netSavings;
  final String balanceStatus;
  final String? warning;

  const FinancialWealthSummary({
    required this.success,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalLoan,
    required this.netSavings,
    required this.balanceStatus,
    required this.warning,
  });

  factory FinancialWealthSummary.fromJson(Map<String, dynamic> json) {
    return FinancialWealthSummary(
      success: json['success'] == true,
      totalIncome: FinancialIncome._toDouble(json['totalIncome']),
      totalExpense: FinancialIncome._toDouble(json['totalExpense']),
      totalLoan: FinancialIncome._toDouble(json['totalLoan']),
      netSavings: FinancialIncome._toDouble(json['netSavings']),
      balanceStatus: json['balanceStatus']?.toString() ?? '',
      warning: json['warning']?.toString(),
    );
  }
}

class FinancialLoanCalculationResult {
  final double emi;
  final double totalRepayment;
  final double interest;

  const FinancialLoanCalculationResult({
    required this.emi,
    required this.totalRepayment,
    required this.interest,
  });

  factory FinancialLoanCalculationResult.fromJson(Map<String, dynamic> json) {
    return FinancialLoanCalculationResult(
      emi: FinancialIncome._toDouble(json['emi']),
      totalRepayment: FinancialIncome._toDouble(json['totalRepayment']),
      interest: FinancialIncome._toDouble(json['interest']),
    );
  }
}

extension _StringDefault on String {
  String ifEmpty(String fallback) {
    if (trim().isEmpty) {
      return fallback;
    }
    return this;
  }
}
