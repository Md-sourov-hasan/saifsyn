import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/subscription/data/model/subscription_plan_model.dart';
import 'package:saifsyn/features/subscription/data/service/subscription_service.dart';
import 'package:saifsyn/features/subscription/presentation/screens/stripe_checkout_webview.dart';

class SubscriptionController extends GetxController {
  final RxBool _isEliteMember = false.obs;
  final RxInt _selectedPlanIndex = (-1).obs;
  final RxnInt _subscribedPlanId = RxnInt();
  final RxString _latestPaymentStatus = ''.obs;
  final RxnInt _latestPaymentPlanId = RxnInt();
  final RxString _planName = ''.obs;
  final RxString _planPrice = ''.obs;
  final RxString _expiryDate = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isProcessingPayment = false.obs;

  final RxList<SubscriptionPlanModel> _plans = <SubscriptionPlanModel>[].obs;
  final SubscriptionService _subscriptionService = SubscriptionService();

  bool get isEliteMember => _isEliteMember.value;
  int get selectedPlanIndex => _selectedPlanIndex.value;
  int? get subscribedPlanId => _subscribedPlanId.value;
  String get latestPaymentStatus => _latestPaymentStatus.value;
  int? get latestPaymentPlanId => _latestPaymentPlanId.value;
  String get planName => _planName.value;
  String get planPrice => _planPrice.value;
  String get expiryDate => _expiryDate.value;
  bool get isLoading => _isLoading.value;
  bool get isProcessingPayment => _isProcessingPayment.value;
  List<SubscriptionPlanModel> get plans => _plans;

  SubscriptionPlanModel? get selectedPlan {
    if (_plans.isEmpty) return null;
    if (_selectedPlanIndex.value < 0 ||
        _selectedPlanIndex.value >= _plans.length) {
      return null;
    }
    return _plans[_selectedPlanIndex.value];
  }

  @override
  void onInit() {
    super.onInit();
    _loadSubscriptionStatus();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    try {
      _isLoading.value = true;
      final fetchedPlans = await _subscriptionService.getAllSubscriptions();
      final activePlans = fetchedPlans.where((plan) => plan.status).toList();

      activePlans.sort((a, b) {
        final durationCompare = a.durationValue.compareTo(b.durationValue);
        if (durationCompare != 0) return durationCompare;
        return a.id.compareTo(b.id);
      });

      _plans.assignAll(activePlans);

      _syncSelectedPlanMeta();
      await syncLatestPaymentStatus();
    } catch (e) {
      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('error'),
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void _loadSubscriptionStatus() {
    // Persisted subscription state can be loaded here when API is available.
  }

  Future<void> _saveSubscriptionStatus() async {
    // Persisted subscription state can be saved here when API is available.
  }

  void setSelectedPlan(int index) {
    if (index < 0 || index >= _plans.length) return;
    _selectedPlanIndex.value = _selectedPlanIndex.value == index ? -1 : index;
    _syncSelectedPlanMeta();
  }

  void _syncSelectedPlanMeta() {
    final plan = selectedPlan;
    if (plan == null) {
      _planName.value = '';
      _planPrice.value = '';
      return;
    }
    _planName.value = plan.title;
    _planPrice.value = formatPrice(plan.price);
  }

  String formatPrice(double price) {
    if (price % 1 == 0) {
      return r'$' + price.toInt().toString();
    }
    return r'$' + price.toStringAsFixed(2);
  }

  String pricePerMonthText(SubscriptionPlanModel plan) {
    if (plan.durationValue <= 1) return '';
    final perMonth = plan.price / plan.durationValue;
    return '${formatPrice(perMonth)}/month';
  }

  bool isPlanSubscribed(int planId) {
    return isEliteMember &&
        !isSubscriptionExpired() &&
        _subscribedPlanId.value == planId;
  }

  bool get isSelectedPlanSubscribed {
    final plan = selectedPlan;
    if (plan == null) return false;
    return isPlanSubscribed(plan.id);
  }

  void _applySubscriptionState(
      {required int planId, bool renewFromNow = false}) {
    final planIndex = _plans.indexWhere((plan) => plan.id == planId);
    final plan = planIndex >= 0 ? _plans[planIndex] : null;

    _isEliteMember.value = true;
    _subscribedPlanId.value = planId;
    if (planIndex >= 0) {
      _selectedPlanIndex.value = planIndex;
    }

    if (plan != null) {
      _planName.value = plan.title;
      _planPrice.value = formatPrice(plan.price);
      if (renewFromNow || _expiryDate.value.isEmpty) {
        _expiryDate.value = DateTime.now()
            .add(Duration(days: 30 * plan.durationValue))
            .toString();
      }
    }
  }

  void _clearSubscriptionState() {
    _isEliteMember.value = false;
    _subscribedPlanId.value = null;
    _planName.value = '';
    _planPrice.value = '';
    _expiryDate.value = '';
  }

  Future<void> syncLatestPaymentStatus({bool showError = false}) async {
    try {
      final paymentStatus = await _subscriptionService.getPaymentStatus();
      _latestPaymentStatus.value = paymentStatus.status;
      _latestPaymentPlanId.value = paymentStatus.planId;

      if (paymentStatus.isPaid && paymentStatus.planId != null) {
        _applySubscriptionState(planId: paymentStatus.planId!);
      } else {
        _clearSubscriptionState();
      }
    } catch (e) {
      if (!showError) return;
      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('error'),
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> activateSubscription({required int planId}) async {
    try {
      _latestPaymentStatus.value = 'paid';
      _latestPaymentPlanId.value = planId;
      _applySubscriptionState(planId: planId, renewFromNow: true);

      await _saveSubscriptionStatus();

      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('success'),
        localizationService.translate('subscription_activated'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00008B),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3),
      );

      if (Get.isDialogOpen ?? false) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
      }
    } catch (e) {
      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('error'),
        localizationService.translate('failed_activate_subscription'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> startPayment() async {
    final plan = selectedPlan;
    if (plan == null) {
      Get.snackbar(
        'Select a plan',
        'Please choose a subscription plan to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }

    try {
      _isProcessingPayment.value = true;
      final payment = await _subscriptionService.processPayment(
        planId: plan.id,
        platform: 'web',
      );

      AppLoggerHelper.debug('PAYMENT CHECKOUT URL => ${payment.checkoutUrl}');
      Get.snackbar("proccessing for payment ", "success");
      final success = await Get.to<bool>(
        () => StripeWebView(url: payment.checkoutUrl),
      );

      if (success == true) {
        await activateSubscription(planId: plan.id);
        await syncLatestPaymentStatus();
      }
    } catch (e) {
      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('error'),
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
    } finally {
      _isProcessingPayment.value = false;
    }
  }

  Future<void> cancelSubscription() async {
    try {
      _clearSubscriptionState();
      _latestPaymentStatus.value = '';
      _latestPaymentPlanId.value = null;

      await _saveSubscriptionStatus();

      final localizationService = Get.find<LocalizationService>();
      Get.snackbar(
        localizationService.translate('success'),
        localizationService.translate('subscription_cancelled'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00008B),
        colorText: const Color(0xFFFFFFFF),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to cancel subscription. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB2C36),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  bool isSubscriptionExpired() {
    if (_expiryDate.value.isEmpty) return true;

    try {
      final expiryDateTime = DateTime.parse(_expiryDate.value);
      return DateTime.now().isAfter(expiryDateTime);
    } catch (e) {
      return true;
    }
  }

  int getDaysRemaining() {
    if (_expiryDate.value.isEmpty) return 0;

    try {
      final expiryDateTime = DateTime.parse(_expiryDate.value);
      final difference = expiryDateTime.difference(DateTime.now());
      return difference.inDays > 0 ? difference.inDays : 0;
    } catch (e) {
      return 0;
    }
  }
}
