import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/subscription/data/model/subscription_plan_model.dart';
import '../widgets/subscription_header.dart';
import '../widgets/premium_card.dart';
import '../widgets/subscription_plan_card.dart';
import '../widgets/elite_features_card.dart';
import '../widgets/subscribe_button.dart';
import '../widgets/subscription_info_card.dart';
import '../../controllers/subscription_controller.dart';

class EliteFeature {
  final IconData icon;
  final String title;

  EliteFeature({
    required this.icon,
    required this.title,
  });
}

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final subscriptionController = Get.find<SubscriptionController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (subscriptionController.plans.isEmpty &&
          !subscriptionController.isLoading) {
        await subscriptionController.fetchSubscriptions();
      } else {
        await subscriptionController.syncLatestPaymentStatus();
      }
    });
  }

  void _handleSubscribe() {
    subscriptionController.startPayment();
  }

  List<EliteFeature> _planFeatures(SubscriptionPlanModel plan) {
    if (plan.features.isEmpty) {
      return <EliteFeature>[];
    }

    return plan.features
        .map((feature) => EliteFeature(
              icon: Icons.check_circle_outline,
              title: feature,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SubscriptionHeader(notificationCount: 2),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18.h),

                    // Premium Card
                    const PremiumCard(),

                    SizedBox(height: 29.h),

                    // Choose Your Plan Section
                    Text(
                      localizationService.translate('chooseYourPlan'),
                      style: TextStyle(
                        color: const Color(0xFF101727),
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Obx(() {
                      final latestStatus =
                          subscriptionController.latestPaymentStatus;
                      final hasLatestStatus = latestStatus.isNotEmpty;

                      if (subscriptionController.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (subscriptionController.plans.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text(
                            'No subscription plans available',
                            style: TextStyle(
                              color: const Color(0xFF697282),
                              fontSize: 14.sp,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (hasLatestStatus) ...[
                            Text(
                              'Latest payment: ${latestStatus.toUpperCase()}',
                              style: TextStyle(
                                color: latestStatus == 'paid'
                                    ? const Color(0xFF166534)
                                    : const Color(0xFF9A3412),
                                fontSize: 12.sp,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                          Column(
                            children: List.generate(
                              subscriptionController.plans.length,
                              (index) {
                                final plan =
                                    subscriptionController.plans[index];
                                final perMonthText = subscriptionController
                                    .pricePerMonthText(plan);
                                final isSelected =
                                    subscriptionController.selectedPlanIndex ==
                                        index;
                                final isSubscribed = subscriptionController
                                    .isPlanSubscribed(plan.id);
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index ==
                                            subscriptionController
                                                    .plans.length -
                                                1
                                        ? 0
                                        : 12.h,
                                  ),
                                  child: Column(
                                    children: [
                                      SubscriptionPlanCard(
                                        title: plan.title,
                                        price: subscriptionController
                                            .formatPrice(plan.price),
                                        pricePerMonth: perMonthText.isEmpty
                                            ? null
                                            : perMonthText,
                                        isSelected: isSelected,
                                        isSubscribed: isSubscribed,
                                        onTap: () => subscriptionController
                                            .setSelectedPlan(index),
                                      ),
                                      if (isSelected) ...[
                                        SizedBox(height: 12.h),
                                        EliteFeaturesCard(
                                          features: _planFeatures(plan),
                                        ),
                                        if (!isSubscribed) ...[
                                          SizedBox(height: 12.h),
                                          SubscribeButton(
                                              onPressed: _handleSubscribe),
                                        ],
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 18.h),

                    // Info Card
                    SubscriptionInfoCard(
                      text:
                          localizationService.translate('subscriptionInfoText'),
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
