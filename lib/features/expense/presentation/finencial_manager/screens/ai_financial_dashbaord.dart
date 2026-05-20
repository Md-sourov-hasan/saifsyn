import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/expense_dashboard.dart';
import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/financial_manager_showall.dart';
import 'package:saifsyn/features/expense/presentation/loan_calculator/loan_calculation.dart';
import 'package:saifsyn/features/expense/presentation/wealth_dashboard/wealth_total_savings.dart';

enum _DashboardToolTab { financialManager, loanCalculator, wealthDashboard }

const LinearGradient _financialManagerGradient = LinearGradient(
  colors: [Color(0xFF0A0A88), Color(0xFF2A2AB3)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class AiFinancialDashbaord extends StatefulWidget {
  const AiFinancialDashbaord({super.key});

  @override
  State<AiFinancialDashbaord> createState() => _AiFinancialDashbaordState();
}

class _AiFinancialDashbaordState extends State<AiFinancialDashbaord> {
  _DashboardToolTab _activeTab = _DashboardToolTab.financialManager;
  late final FinancialController _controller;
  final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');
  final NumberFormat _amountFormatter = NumberFormat('#,##0.00', 'en_US');

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<FinancialController>()
        ? Get.find<FinancialController>()
        : Get.put(FinancialController());
    if (_controller.financialManagerShowAll == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.fetchFinancialManagerShowAll(showLoader: false);
      });
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final currentRange = _controller.selectedRange;
    final initialDate = isStart ? currentRange.start : currentRange.end;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) {
      return;
    }

    final updated = isStart
        ? DateTimeRange(start: picked, end: currentRange.end)
        : DateTimeRange(start: currentRange.start, end: picked);

    if (updated.end.isBefore(updated.start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End date cannot be before start date.')),
      );
      return;
    }

    _controller.setSelectedRange(updated);
  }

  @override
  Widget build(BuildContext context) {
    final isFinancialManagerTab =
        _activeTab == _DashboardToolTab.financialManager;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpenseDashboardCard(context),
              SizedBox(height: 12.h),
              _buildTopTabs(),
              SizedBox(height: 12.h),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: KeyedSubtree(
                    key: ValueKey(_activeTab),
                    child: isFinancialManagerTab
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFinancialManagerHeader(),
                                SizedBox(height: 12.h),
                                FinancialManagerShowAll(
                                  showHeader: false,
                                  isScrollable: false,
                                ),
                              ],
                            ),
                          )
                        : _buildTabBody(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openExpenseDashboardForTab(FinancialDashboardTab selectedTab) {
    if (!mounted) {
      return;
    }
    _controller.setActiveTab(selectedTab);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ExpenseDashboardPage(),
      ),
    );
  }

  Widget _buildExpenseDashboardCard(BuildContext context) {
    final popupMenuTheme = Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
    final popupOptions = <_FinancialDashboardPopupOption>[
      const _FinancialDashboardPopupOption(
        tab: FinancialDashboardTab.income,
        title: 'Income',
        subtitle: 'Salary and revenue',
        icon: Icons.trending_up_rounded,
      ),
      const _FinancialDashboardPopupOption(
        tab: FinancialDashboardTab.expense,
        title: 'Expense',
        subtitle: 'Daily and monthly spend',
        icon: Icons.receipt_long_rounded,
      ),
      const _FinancialDashboardPopupOption(
        tab: FinancialDashboardTab.loan,
        title: 'Loan',
        subtitle: 'Borrowing and repayments',
        icon: Icons.account_balance_rounded,
      ),
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const ExpenseDashboardPage(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            gradient: _financialManagerGradient,
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Financial Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Open Income, Expense and Loan tabs',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Theme(
                data: popupMenuTheme,
                child: PopupMenuButton<FinancialDashboardTab>(
                  tooltip: 'Open Financial Tabs',
                  onSelected: _openExpenseDashboardForTab,
                  // color: const Color(0xFF0A0A88),
                  position: PopupMenuPosition.under,
                  elevation: 10,
                  surfaceTintColor: Colors.white,
                  offset: Offset(10.h, 30.h),
                  constraints: BoxConstraints(minWidth: 252.w),
                  menuPadding: EdgeInsets.all(8.w),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  itemBuilder: (menuContext) {
                    return popupOptions.map((option) {
                      return PopupMenuItem<FinancialDashboardTab>(
                        value: option.tab,
                        padding: EdgeInsets.zero,
                        child: _FinancialDashboardPopupTile(
                          option: option,
                          isSelected: _controller.activeTab == option.tab,
                        ),
                      );
                    }).toList();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      gradient: _financialManagerGradient,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.26),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Tabs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopTabs() {
    final tabs = <_DashboardTabChipData>[
      _DashboardTabChipData(
        label: 'Financial Manager',
        icon: Icons.auto_awesome_outlined,
        tab: _DashboardToolTab.financialManager,
      ),
      _DashboardTabChipData(
        label: 'Loan Calculator',
        icon: Icons.calculate_outlined,
        tab: _DashboardToolTab.loanCalculator,
      ),
      _DashboardTabChipData(
        label: 'Wealth Dashboard',
        icon: Icons.savings_outlined,
        tab: _DashboardToolTab.wealthDashboard,
      ),
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: tabs
          .map(
            (item) => _DashboardTabChip(
              label: item.label,
              icon: item.icon,
              isSelected: _activeTab == item.tab,
              onTap: () => setState(() => _activeTab = item.tab),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFinancialManagerHeader() {
    return Obx(() {
      final data = _controller.financialManagerShowAll;
      final range = _controller.selectedRange;
      final isLoading = _controller.isFinancialManagerShowAllLoading;
      final apiMessage = _controller.financialManagerShowAllMessage;
      final hasNoData = !isLoading && data != null && !data.hasData;
      final noDataMessage = apiMessage.isNotEmpty
          ? apiMessage
          : 'No financial data for selected period';
      final metrics = <_HeaderMetricData>[
        _HeaderMetricData('Total Income', data?.totalIncome ?? 0),
        _HeaderMetricData('Total Expense', data?.totalExpense ?? 0),
        _HeaderMetricData('Total Loan', data?.totalLoan ?? 0),
        _HeaderMetricData('Net Balance', data?.netBalance ?? 0),
      ];

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Manager',
              style: TextStyle(
                color: const Color(0xFF111827),
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 760) {
                  return Row(
                    children: [
                      Expanded(
                        child: _HeaderDateField(
                          label: 'FROM DATE',
                          value: _dateFormatter.format(range.start),
                          onTap: () => _pickDate(isStart: true),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _HeaderDateField(
                          label: 'TO DATE',
                          value: _dateFormatter.format(range.end),
                          onTap: () => _pickDate(isStart: false),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        height: 46.h,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () =>
                                  _controller.fetchFinancialManagerShowAll(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00008B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Fetch',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    _HeaderDateField(
                      label: 'FROM DATE',
                      value: _dateFormatter.format(range.start),
                      onTap: () => _pickDate(isStart: true),
                    ),
                    SizedBox(height: 8.h),
                    _HeaderDateField(
                      label: 'TO DATE',
                      value: _dateFormatter.format(range.end),
                      onTap: () => _pickDate(isStart: false),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => _controller.fetchFinancialManagerShowAll(),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: const Color(0xFF00008B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Fetch',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10.h),
            if (hasNoData)
              _HeaderStatusCard(message: noDataMessage)
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 760) {
                    return Row(
                      children: List.generate(metrics.length, (index) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index == metrics.length - 1 ? 0 : 8.w,
                            ),
                            child: _HeaderMetricCard(
                              label: metrics[index].label,
                              value:
                                  _amountFormatter.format(metrics[index].value),
                            ),
                          ),
                        );
                      }),
                    );
                  }

                  return Column(
                    children: List.generate(metrics.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == metrics.length - 1 ? 0 : 8.h,
                        ),
                        child: _HeaderMetricCard(
                          label: metrics[index].label,
                          value: _amountFormatter.format(metrics[index].value),
                        ),
                      );
                    }),
                  );
                },
              ),
          ],
        ),
      );
    });
  }

  Widget _buildTabBody() {
    switch (_activeTab) {
      case _DashboardToolTab.financialManager:
        return FinancialManagerShowAll(showHeader: false);
      case _DashboardToolTab.loanCalculator:
        return const LoanCalculation();
      case _DashboardToolTab.wealthDashboard:
        return const WealthTotalSavings();
    }
  }
}

class _HeaderMetricData {
  const _HeaderMetricData(this.label, this.value);

  final String label;
  final double value;
}

class _HeaderDateField extends StatelessWidget {
  const _HeaderDateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: const Color(0xFF111827),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: const Color(0xFF6B7280),
                    size: 16.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderMetricCard extends StatelessWidget {
  const _HeaderMetricCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: r' $',
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderStatusCard extends StatelessWidget {
  const _HeaderStatusCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: const Color(0xFF6B7280),
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: const Color(0xFF4B5563),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialDashboardPopupOption {
  const _FinancialDashboardPopupOption({
    required this.tab,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final FinancialDashboardTab tab;
  final String title;
  final String subtitle;
  final IconData icon;
}

class _FinancialDashboardPopupTile extends StatelessWidget {
  const _FinancialDashboardPopupTile({
    required this.option,
    required this.isSelected,
  });

  final _FinancialDashboardPopupOption option;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      padding: EdgeInsets.fromLTRB(10.w, 9.h, 10.w, 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: isSelected
            ? _financialManagerGradient
            : LinearGradient(
                colors: [
                  const Color(0xFF0A0A88).withValues(alpha: 0.85),
                  const Color(0xFF2A2AB3).withValues(alpha: 0.85),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        border: Border.all(
          color: Colors.white.withValues(alpha: isSelected ? 0.28 : 0.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              option.icon,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  option.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: const Color(0xFF0A0A88),
                size: 13.sp,
              ),
            ),
        ],
      ),
    );
  }
}

class _DashboardTabChipData {
  const _DashboardTabChipData({
    required this.label,
    required this.icon,
    required this.tab,
  });

  final String label;
  final IconData icon;
  final _DashboardToolTab tab;
}

class _DashboardTabChip extends StatelessWidget {
  const _DashboardTabChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 38.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00008B) : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF00008B)
                  : const Color(0xFFD9DDE5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.white : const Color(0xFF4B5563),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
