import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_formatters.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_item_actions.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_table_container.dart';

class LoanTable extends StatelessWidget {
  const LoanTable({
    super.key,
    required this.loans,
    required this.isSubmitting,
    required this.onEdit,
    required this.onDelete,
    required this.onView,
  });

  final List<FinancialLoan> loans;
  final bool isSubmitting;
  final void Function(FinancialLoan loan) onEdit;
  final void Function(int loanId) onDelete;
  final void Function(int loanId) onView;

  @override
  Widget build(BuildContext context) {
    return FinancialTableContainer(
      minTableWidth: 1100.w,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFFE5E7EB)),
        headingTextStyle: TextStyle(
          color: const Color(0xFF374151),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: TextStyle(
          color: const Color(0xFF111827),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        border: const TableBorder(
          horizontalInside: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        horizontalMargin: 16.w,
        columnSpacing: 18.w,
        columns: [
          DataColumn(
            label: SizedBox(
              width: 210.w,
              child: const Text('Title'),
            ),
          ),
          DataColumn(
            numeric: true,
            label: SizedBox(
              width: 120.w,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text('Amount'),
              ),
            ),
          ),
          DataColumn(
            numeric: true,
            label: SizedBox(
              width: 100.w,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text('Rate'),
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 130.w,
              child: const Text('Period'),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 150.w,
              child: const Text('Start Date'),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 150.w,
              child: const Text('Actions'),
            ),
          ),
        ],
        rows: loans.map((item) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 210.w,
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 120.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(FinancialFormatters.amount(item.amount)),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(FinancialFormatters.rate(item.interestRate)),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 130.w,
                  child: Text(FinancialFormatters.period(item.repaymentPeriod)),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 150.w,
                  child: Text(FinancialFormatters.date(item.startDate)),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 150.w,
                  child: FinancialRecordActions(
                    isSubmitting: isSubmitting,
                    onEdit: () => onEdit(item),
                    onDelete: () => onDelete(item.id),
                    onView: () => onView(item.id),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
