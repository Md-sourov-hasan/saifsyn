import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/premium_feature/budget/presentation/screens/budget_manager_screen.dart';
import 'package:saifsyn/features/premium_feature/commodities/presentation/screens/commodities_screen.dart';
import 'package:saifsyn/features/premium_feature/crypto/presentation/screens/crypto_screen.dart';
import 'package:saifsyn/features/premium_feature/opportunity_stocks/presentation/screens/opportunity_stocks_screen.dart';
import 'package:saifsyn/features/premium_feature/support/presentation/screens/support_chat_screen.dart';

class PremiumFeaturesCard extends StatelessWidget {
  const PremiumFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 5,
            offset: Offset(0, 0),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            localizationService.translate('premiumFeatures'),
            style: TextStyle(
              color: const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          SizedBox(height: 16.h),

          // Features grid
          Column(
            children: [
              // First row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureItem(
                    icon: Icons.diamond_outlined,
                    label: localizationService.translate('opportunityStocks'),
                    isActive: false,
                    onTap: () {
                      Get.to(() => const OpportunityStocksScreen());
                    },
                  ),
                  _buildFeatureItem(
                      icon: Icons.trending_up_outlined,
                      label: localizationService.translate('commodities'),
                      isActive: false,
                      onTap: () {
                        Get.to(() => const CommoditiesScreen());
                      }),
                  _buildFeatureItem(
                    icon: Icons.currency_bitcoin,
                    label: localizationService.translate('cryptoTracking'),
                    isActive: false,
                    onTap: () {
                      Get.to(() => const CryptoScreen());
                    },
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // Second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureItem(
                    icon: Icons.wallet_outlined,
                    label: localizationService.translate('budgetManager'),
                    isActive: false,
                    onTap: () {
                      Get.to(() => const BudgetManagerScreen());
                    },
                  ),
                  _buildFeatureItem(
                    icon: Icons.track_changes_rounded,
                    label: localizationService.translate('goalsTracking'),
                    isActive: false,
                  ),
                  _buildFeatureItem(
                    icon: Icons.chat_bubble_outline,
                    label: localizationService.translate('directSupport'),
                    isActive: false,
                    onTap: () {
                      Get.to(() => const SupportChatScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          width: 88.w,
          height: 88.h,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF00008B) : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: isActive ? Colors.white : const Color(0xFF354152),
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF354152),
                  fontSize: 11.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
