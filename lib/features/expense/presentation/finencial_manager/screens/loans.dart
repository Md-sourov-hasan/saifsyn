import 'package:flutter/material.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_dialogs.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_formatters.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_tab_content.dart';
import 'package:saifsyn/features/expense/widgets/loans/loan_form_dialog.dart';
import 'package:saifsyn/features/expense/widgets/loans/loan_table.dart';

class LoansTab extends StatelessWidget {
  const LoansTab({
    super.key,
    required this.controller,
  });

  final FinancialController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FinancialLoan>>(
      stream: controller.loansStream,
      initialData: controller.loans.toList(),
      builder: (context, loansSnapshot) {
        final loans = loansSnapshot.data ?? <FinancialLoan>[];

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
                  title: 'Loan',
                  subtitle:
                      'Track your liabilities and repayment schedule clearly',
                  addButtonLabel: 'Add Loan',
                  isSubmitting: isSubmitting,
                  onAdd: () => _showLoanFormDialog(context),
                  onRefresh: controller.refreshLoans,
                  isLoading: isLoading,
                  isEmpty: loans.isEmpty,
                  emptyMessage: controller.errorMessage.isNotEmpty
                      ? controller.errorMessage
                      : 'No loan data found',
                  table: LoanTable(
                    loans: loans,
                    isSubmitting: isSubmitting,
                    onEdit: (loan) => _showLoanFormDialog(context, loan: loan),
                    onDelete: (loanId) => _confirmDeleteLoan(context, loanId),
                    onView: (loanId) => _showLoanDetails(context, loanId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _showLoanFormDialog(
    BuildContext context, {
    FinancialLoan? loan,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => LoanFormDialog(
        controller: controller,
        loan: loan,
      ),
    );
  }

  Future<void> _confirmDeleteLoan(BuildContext context, int loanId) async {
    final shouldDelete = await showDeleteConfirmationDialog(
      context,
      itemType: 'loan',
    );

    if (shouldDelete) {
      await controller.deleteLoan(loanId);
    }
  }

  Future<void> _showLoanDetails(BuildContext context, int loanId) async {
    final details = await controller.getLoanDetails(loanId);
    if (details == null || !context.mounted) {
      return;
    }

    await showFinancialDetailsDialog(
      context,
      title: 'Loan Details',
      details: [
        FinancialDetailItem(label: 'Title', value: details.title),
        FinancialDetailItem(
          label: 'Amount',
          value: FinancialFormatters.amount(details.amount),
        ),
        FinancialDetailItem(
          label: 'Interest Rate',
          value: FinancialFormatters.rate(details.interestRate),
        ),
        FinancialDetailItem(
          label: 'Repayment',
          value: FinancialFormatters.period(details.repaymentPeriod),
        ),
        FinancialDetailItem(
          label: 'Start Date',
          value: FinancialFormatters.date(details.startDate),
        ),
        FinancialDetailItem(label: 'ID', value: details.id.toString()),
      ],
    );
  }
}
