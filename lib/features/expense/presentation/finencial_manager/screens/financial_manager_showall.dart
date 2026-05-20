import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';

class FinancialManagerShowAll extends GetView<FinancialController> {
  FinancialManagerShowAll({
    super.key,
    this.showHeader = true,
    this.isScrollable = true,
  }) {
    if (!Get.isRegistered<FinancialController>()) {
      Get.put(FinancialController());
    }
  }

  final bool showHeader;
  final bool isScrollable;

  // Modern Color Palette
  static const Color primaryBlue = Color(0xFF00008B);
  static const Color surfaceWhite = Colors.white;
  static const Color backgroundGray = Color(0xFFF8FAFC);
  static const Color borderBlue = Color(0xFFE2E8F0);

  final _currency = NumberFormat.simpleCurrency(decimalDigits: 0);
  final _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.financialManagerShowAll;
      final isLoading = controller.isFinancialManagerShowAllLoading;
      final apiMessage = controller.financialManagerShowAllMessage;
      final noDataMessage = apiMessage.isNotEmpty
          ? apiMessage
          : 'No financial data for selected period';

      Widget content = Container(
        decoration: BoxDecoration(
          color: backgroundGray,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderBlue),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader) _buildHeader(context, isLoading),
            if (isLoading)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              )
            else if (data != null && data.hasData) ...[
              _buildInsightSection(data),
            ] else if (data != null || apiMessage.isNotEmpty) ...[
              _buildNoDataState(noDataMessage),
            ],
          ],
        ),
      );

      return isScrollable ? SingleChildScrollView(child: content) : content;
    });
  }

  Widget _buildHeader(BuildContext context, bool isLoading) {
    final range = controller.selectedRange;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Analysis',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: primaryBlue,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _DateButton(
              label: 'From',
              value: _dateFormatter.format(range.start),
              onTap: () => _pickDate(context, isStart: true),
            ),
            SizedBox(width: 8.w),
            _DateButton(
              label: 'To',
              value: _dateFormatter.format(range.end),
              onTap: () => _pickDate(context, isStart: false),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _StatGrid(
          income: controller.financialManagerShowAll?.totalIncome ?? 0,
          expense: controller.financialManagerShowAll?.totalExpense ?? 0,
          loan: controller.financialManagerShowAll?.totalLoan ?? 0,
          currency: _currency,
        ),
      ],
    );
  }

  Widget _buildInsightSection(dynamic data) {
    final ai = data.aiInsights;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            // color: primaryBlue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.black, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                'AI INTELLIGENCE',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Main Insight Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: backgroundGray,
            border: Border.all(color: borderBlue, width: 1.5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currency.format(data.netBalance),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              Text(
                'Current Net Balance • ${data.balanceStatus.toUpperCase()}',
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Divider(color: borderBlue, thickness: 1),
              ),
              if (ai?.insights != null)
                ...(ai.insights as List<String>)
                    .map((text) => _buildInsightRow(text)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoDataState(String message) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderBlue),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.info,
              size: 18.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontSize: 13.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: primaryBlue, size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF334155),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, {required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? controller.selectedRange.start
          : controller.selectedRange.end,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final newRange = isStart
          ? DateTimeRange(start: picked, end: controller.selectedRange.end)
          : DateTimeRange(start: controller.selectedRange.start, end: picked);
      controller.setSelectedRange(newRange);
      controller.fetchFinancialManagerShowAll();
    }
  }
}

class _StatGrid extends StatelessWidget {
  final double income, expense, loan;
  final NumberFormat currency;
  const _StatGrid(
      {required this.income,
      required this.expense,
      required this.loan,
      required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatTile('Income', income),
        SizedBox(width: 12.w),
        _buildStatTile('Expenses', expense),
        SizedBox(width: 12.w),
        _buildStatTile('Loans', loan),
      ],
    );
  }

  Widget _buildStatTile(String label, double value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border.all(color: FinancialManagerShowAll.borderBlue),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.blueGrey[300],
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            FittedBox(
              child: Text(
                currency.format(value),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: FinancialManagerShowAll.primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;
  const _DateButton(
      {required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: FinancialManagerShowAll.borderBlue),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$label: $value',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
              const Icon(Icons.calendar_today,
                  size: 14, color: FinancialManagerShowAll.primaryBlue),
            ],
          ),
        ),
      ),
    );
  }
}
