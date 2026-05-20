import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/premium_feature_header.dart';
import '../widgets/budget_summary_cards.dart';
import '../widgets/expense_breakdown_card.dart';
import '../widgets/budget_action_buttons.dart';
import '../widgets/recent_transactions_card.dart';

class BudgetManagerScreen extends StatelessWidget {
  const BudgetManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const PremiumFeatureHeader(
                title: 'Budget Manager',
                subtitle: 'Plan, track, and control your expenses effectively.',
              ),

              SizedBox(height: 18.h),

              // Budget Summary Cards (Income, Expenses, Balance)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const BudgetSummaryCards(),
              ),

              SizedBox(height: 18.h),

              // Expense Breakdown Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const ExpenseBreakdownCard(),
              ),

              SizedBox(height: 21.h),

              // Action Buttons (Add Income / Add Expense)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const BudgetActionButtons(),
              ),

              SizedBox(height: 27.h),

              // Recent Transactions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const RecentTransactionsCard(),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
