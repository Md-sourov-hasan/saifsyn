import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/features/expense/controllers/financial_controller.dart';
import 'package:saifsyn/features/expense/services/financial_services.dart';
import 'package:saifsyn/features/expense/widgets/common/financial_formatters.dart';

class IncomeFormDialog extends StatefulWidget {
  const IncomeFormDialog({
    super.key,
    required this.controller,
    this.income,
  });

  final FinancialController controller;
  final FinancialIncome? income;

  @override
  State<IncomeFormDialog> createState() => _IncomeFormDialogState();
}

class _IncomeFormDialogState extends State<IncomeFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late DateTime _selectedDate;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.income?.title ?? '');
    _amountController = TextEditingController(
      text: widget.income == null
          ? ''
          : FinancialFormatters.amountInput(widget.income!.amount),
    );
    _selectedDate = widget.income?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    if (_isSubmitting) {
      return;
    }

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _selectedDate,
    );

    if (pickedDate != null && mounted) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting || widget.controller.isSubmitting) {
      return;
    }

    setState(() => _isSubmitting = true);

    final isSuccess = widget.income == null
        ? await widget.controller.createIncome(
            title: _titleController.text,
            amountText: _amountController.text,
            date: _selectedDate,
          )
        : await widget.controller.updateIncome(
            id: widget.income!.id,
            title: _titleController.text,
            amountText: _amountController.text,
            date: _selectedDate,
          );

    if (!mounted) {
      return;
    }

    if (isSuccess) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
      contentPadding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
      actionsPadding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
      title: Text(
        widget.income == null ? 'Add Income' : 'Update Income',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 360.w,
          maxHeight: 300.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Freelance Payment',
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: '500',
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Date',
                style: TextStyle(
                  color: const Color(0xFF374151),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              InkWell(
                onTap: _isSubmitting ? null : _pickDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD1D5DB)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    FinancialFormatters.date(_selectedDate),
                    style: TextStyle(
                      color: const Color(0xFF111827),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF374151),
            side: const BorderSide(color: Color(0xFFD1D5DB)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            side: BorderSide.none,
            backgroundColor: const Color(0xFF00008B),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: _isSubmitting
              ? SizedBox(
                  height: 16.h,
                  width: 16.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(widget.income == null ? 'Save' : 'Update'),
        ),
      ],
    );
  }
}
