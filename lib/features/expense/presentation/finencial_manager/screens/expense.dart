import 'package:flutter/material.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_dialogs.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_formatters.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_tab_content.dart';
import 'package:saifsyn/features/expense/widgets/expense/expense_form_dialog.dart';
import 'package:saifsyn/features/expense/widgets/expense/expense_table.dart';

class ExpensesTab extends StatelessWidget {
  const ExpensesTab({
    super.key,
    required this.controller,
  });

  final FinancialController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FinancialExpense>>(
      stream: controller.expensesStream,
      initialData: controller.expenses.toList(),
      builder: (context, expensesSnapshot) {
        final expenses = expensesSnapshot.data ?? <FinancialExpense>[];

        return StreamBuilder<bool>(
          stream: controller.loadingStream,
          initialData: controller.isLoading,
          builder: (context, loadingSnapshot) {
            final isLoading = loadingSnapshot.data ?? false;

            return StreamBuilder<bool>(
              stream: controller.submittingStream,
              initialData: controller.isSubmitting,
              builder: (context, submittingSnapshot) {
                final isSubmitting = submittingSnapshot.data ?? false;

                return FinancialTabContent(
                  title: 'Expense',
                  subtitle: 'Smart financial planning powered by AI',
                  addButtonLabel: 'Add Expense',
                  isSubmitting: isSubmitting,
                  onAdd: () => _showExpenseFormDialog(context),
                  onRefresh: controller.refreshExpenses,
                  isLoading: isLoading,
                  isEmpty: expenses.isEmpty,
                  emptyMessage: controller.errorMessage.isNotEmpty
                      ? controller.errorMessage
                      : 'No expense data found',
                  table: ExpenseTable(
                    expenses: expenses,
                    isSubmitting: isSubmitting,
                    onEdit: (expense) =>
                        _showExpenseFormDialog(context, expense: expense),
                    onDelete: (expenseId) =>
                        _confirmDeleteExpense(context, expenseId),
                    onView: (expenseId) =>
                        _showExpenseDetails(context, expenseId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _showExpenseFormDialog(
    BuildContext context, {
    FinancialExpense? expense,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => ExpenseFormDialog(
        controller: controller,
        expense: expense,
      ),
    );
  }

  Future<void> _confirmDeleteExpense(
      BuildContext context, int expenseId) async {
    final shouldDelete = await showDeleteConfirmationDialog(
      context,
      itemType: 'expense',
    );

    if (shouldDelete) {
      await controller.deleteExpense(expenseId);
    }
  }

  Future<void> _showExpenseDetails(BuildContext context, int expenseId) async {
    final details = await controller.getExpenseDetails(expenseId);
    if (details == null || !context.mounted) {
      return;
    }

    await showFinancialDetailsDialog(
      context,
      title: 'Expense Details',
      details: [
        FinancialDetailItem(label: 'Title', value: details.title),
        FinancialDetailItem(
          label: 'Amount',
          value: FinancialFormatters.amount(details.amount),
        ),
        FinancialDetailItem(
          label: 'Date',
          value: FinancialFormatters.date(details.date),
        ),
        FinancialDetailItem(label: 'ID', value: details.id.toString()),
      ],
    );
  }
}
