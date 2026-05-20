import 'package:flutter/material.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_dialogs.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_formatters.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_tab_content.dart';
import 'package:saifsyn/features/expense/widgets/incomes/income_form_dialog.dart';
import 'package:saifsyn/features/expense/widgets/incomes/income_table.dart';

class IncomesTab extends StatelessWidget {
  const IncomesTab({
    super.key,
    required this.controller,
  });

  final FinancialController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FinancialIncome>>(
      stream: controller.incomesStream,
      initialData: controller.incomes.toList(),
      builder: (context, incomesSnapshot) {
        final incomes = incomesSnapshot.data ?? <FinancialIncome>[];

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
                  title: 'Income',
                  subtitle: 'Smart financial planning powered by AI',
                  addButtonLabel: 'Add Income',
                  isSubmitting: isSubmitting,
                  onAdd: () => _showIncomeFormDialog(context),
                  onRefresh: controller.refreshIncomes,
                  isLoading: isLoading,
                  isEmpty: incomes.isEmpty,
                  emptyMessage: controller.errorMessage.isNotEmpty
                      ? controller.errorMessage
                      : 'No income data found',
                  table: IncomeTable(
                    incomes: incomes,
                    isSubmitting: isSubmitting,
                    onEdit: (income) =>
                        _showIncomeFormDialog(context, income: income),
                    onDelete: (incomeId) =>
                        _confirmDeleteIncome(context, incomeId),
                    onView: (incomeId) => _showIncomeDetails(context, incomeId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _showIncomeFormDialog(
    BuildContext context, {
    FinancialIncome? income,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => IncomeFormDialog(
        controller: controller,
        income: income,
      ),
    );
  }

  Future<void> _confirmDeleteIncome(BuildContext context, int incomeId) async {
    final shouldDelete = await showDeleteConfirmationDialog(
      context,
      itemType: 'income',
    );

    if (shouldDelete) {
      await controller.deleteIncome(incomeId);
    }
  }

  Future<void> _showIncomeDetails(BuildContext context, int incomeId) async {
    final details = await controller.getIncomeDetails(incomeId);
    if (details == null || !context.mounted) {
      return;
    }

    await showFinancialDetailsDialog(
      context,
      title: 'Income Details',
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
