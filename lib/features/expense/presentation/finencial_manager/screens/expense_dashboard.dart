import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/expense.dart';
import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/incomes.dart';
import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/loans.dart';

class ExpenseDashboardPage extends StatelessWidget {
  const ExpenseDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FinancialController controller =
        Get.isRegistered<FinancialController>()
            ? Get.find<FinancialController>()
            : Get.put(FinancialController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Expense Dashboard',
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopTabs(controller),
                SizedBox(height: 14.h),
                Expanded(
                  child: _buildTabBody(controller),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopTabs(FinancialController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _tabChip(
              label: 'Income',
              isSelected: controller.activeTab == FinancialDashboardTab.income,
              onTap: () =>
                  controller.setActiveTab(FinancialDashboardTab.income),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: _tabChip(
              label: 'Expense',
              isSelected: controller.activeTab == FinancialDashboardTab.expense,
              onTap: () =>
                  controller.setActiveTab(FinancialDashboardTab.expense),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: _tabChip(
              label: 'Loan',
              isSelected: controller.activeTab == FinancialDashboardTab.loan,
              onTap: () => controller.setActiveTab(FinancialDashboardTab.loan),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00008B) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF374151),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBody(FinancialController controller) {
    switch (controller.activeTab) {
      case FinancialDashboardTab.income:
        return IncomesTab(controller: controller);
      case FinancialDashboardTab.expense:
        return ExpensesTab(controller: controller);
      case FinancialDashboardTab.loan:
        return LoansTab(controller: controller);
    }
  }
}
