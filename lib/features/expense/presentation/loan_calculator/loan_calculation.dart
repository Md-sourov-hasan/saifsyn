import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';

class LoanCalculation extends StatefulWidget {
  const LoanCalculation({super.key});

  @override
  State<LoanCalculation> createState() => _LoanCalculationState();
}

class _LoanCalculationState extends State<LoanCalculation> {
  late final FinancialController _controller;
  final TextEditingController _amountController = TextEditingController(
    text: '5000',
  );
  final TextEditingController _durationController = TextEditingController(
    text: '12',
  );
  final TextEditingController _rateController = TextEditingController(
    text: '5.5',
  );
  final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<FinancialController>()
        ? Get.find<FinancialController>()
        : Get.put(FinancialController());
    if (_controller.loanCalculationResult == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculate();
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _durationController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    await _controller.calculateFinancialLoan(
      amountText: _amountController.text,
      interestRateText: _rateController.text,
      repaymentPeriodText: _durationController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        final result = _controller.loanCalculationResult;
        final isLoading = _controller.isLoanCalculationLoading;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFDDE1E7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Calculator',
                style: TextStyle(
                  color: const Color(0xFF111827),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 14.h),
              _inputLayout(),
              SizedBox(height: 14.h),
              SizedBox(
                height: 42.h,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _calculate,
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor: const Color(0xFF00008B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Calculate',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
              if (result != null) ...[
                SizedBox(height: 14.h),
                _buildResultCard(result),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _inputLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 760.w) {
          return Row(
            children: [
              Expanded(
                child: _LoanInputField(
                  label: 'Loan Amount (\$)',
                  controller: _amountController,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: _LoanInputField(
                  label: 'Duration (Months)',
                  controller: _durationController,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: _LoanInputField(
                  label: 'Interest Rate (%)',
                  controller: _rateController,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _LoanInputField(
              label: 'Loan Amount (\$)',
              controller: _amountController,
            ),
            SizedBox(height: 10.h),
            _LoanInputField(
              label: 'Duration (Months)',
              controller: _durationController,
            ),
            SizedBox(height: 10.h),
            _LoanInputField(
              label: 'Interest Rate (%)',
              controller: _rateController,
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultCard(result) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estimated Result',
            style: TextStyle(
              color: const Color(0xFF111827),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          _ResultRow(
            title: 'Monthly Payment',
            value: _currency.format(result.emi),
          ),
          SizedBox(height: 6.h),
          _ResultRow(
            title: 'Total Repayment',
            value: _currency.format(result.totalRepayment),
          ),
          SizedBox(height: 6.h),
          _ResultRow(
            title: 'Total Interest',
            value: _currency.format(result.interest),
          ),
        ],
      ),
    );
  }
}

class _LoanInputField extends StatelessWidget {
  const _LoanInputField({
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF374151),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF00008B)),
            ),
          ),
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF111827)),
        ),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: const Color(0xFF4B5563), fontSize: 14.sp),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
