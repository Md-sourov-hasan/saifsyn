import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';

class WealthTotalSavings extends StatefulWidget {
  const WealthTotalSavings({super.key});

  @override
  State<WealthTotalSavings> createState() => _WealthTotalSavingsState();
}

class _WealthTotalSavingsState extends State<WealthTotalSavings> {
  late final FinancialController _controller;
  final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<FinancialController>()
        ? Get.find<FinancialController>()
        : Get.put(FinancialController());
    if (_controller.financialWealthSummary == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.fetchFinancialWealthSummary();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        final data = _controller.financialWealthSummary;
        final isLoading = _controller.isFinancialWealthLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNetWorthCard(
              netSavings: data?.netSavings ?? 0,
              status: data?.balanceStatus ?? '',
            ),
            SizedBox(height: 14.h),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 42.h,
                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => _controller.fetchFinancialWealthSummary(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00008B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  icon: isLoading
                      ? SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.refresh_rounded, size: 18.sp),
                  label: Text(
                    isLoading ? 'Loading...' : 'Refresh',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            _buildSummaryTable(data),
          ],
        );
      }),
    );
  }

  Widget _buildNetWorthCard({
    required double netSavings,
    required String status,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF4F46E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Net Worth',
            style: TextStyle(
              color: const Color(0xFF00008B),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            _currency.format(netSavings),
            style: TextStyle(
              color: const Color(0xFF111827),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (status.trim().isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              'Status: $status',
              style: TextStyle(color: const Color(0xFF4B5563), fontSize: 14.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryTable(dynamic data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDDE1E7)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: TextStyle(
            color: const Color(0xFF4B5563),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          dataTextStyle: TextStyle(
            color: const Color(0xFF1F2937),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          columns: const [
            DataColumn(label: Text('Metric')),
            DataColumn(label: Text('Value')),
          ],
          rows: [
            _metricRow(
                'Total Income', _currency.format(data?.totalIncome ?? 0)),
            _metricRow(
                'Total Expense', _currency.format(data?.totalExpense ?? 0)),
            _metricRow('Total Loan', _currency.format(data?.totalLoan ?? 0)),
            _metricRow('Net Savings', _currency.format(data?.netSavings ?? 0)),
            _metricRow(
              'Balance Status',
              _fallbackText(data?.balanceStatus, '-'),
            ),
            _metricRow(
              'Warning',
              _fallbackText(data?.warning, 'None'),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _metricRow(String name, String value) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(value)),
      ],
    );
  }

  String _fallbackText(dynamic value, String fallback) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) {
      return fallback;
    }
    return text;
  }
}
