import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Transactions',
            style: TextStyle(
              color: const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 16.h),
          Column(
            children: [
              _buildTransactionItem(
                title: 'Salary',
                date: 'Dec 1, 2025',
                amount: '+\$7500',
                isIncome: true,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Freelance',
                date: 'Dec 10, 2025',
                amount: '+\$1000',
                isIncome: true,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Housing',
                date: 'Dec 1, 2025',
                amount: '-\$2000',
                isIncome: false,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Food',
                date: 'Dec 5, 2025',
                amount: '-\$800',
                isIncome: false,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Transportation',
                date: 'Dec 8, 2025',
                amount: '-\$400',
                isIncome: false,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Utilities',
                date: 'Dec 10, 2025',
                amount: '-\$300',
                isIncome: false,
              ),
              SizedBox(height: 12.h),
              _buildTransactionItem(
                title: 'Entertainment',
                date: 'Dec 12, 2025',
                amount: '-\$500',
                isIncome: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isIncome,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isIncome ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 16.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                date,
                style: TextStyle(
                  color: const Color(0xFF697282),
                  fontSize: 14.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              color:
                  isIncome ? const Color(0xFF00008B) : const Color(0xFFE7000B),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}
