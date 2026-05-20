class PaymentStatusResponse {
  final String status;
  final int? planId;

  const PaymentStatusResponse({
    required this.status,
    required this.planId,
  });

  bool get isPaid => status.toLowerCase() == 'paid';

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    final latestPayment = json['latest_payment'];
    if (latestPayment is! Map<String, dynamic>) {
      return const PaymentStatusResponse(status: '', planId: null);
    }

    final plan = latestPayment['plan'];
    final rawPlanId = plan is Map<String, dynamic> ? plan['id'] : null;

    return PaymentStatusResponse(
      status: latestPayment['status']?.toString().toLowerCase().trim() ?? '',
      planId: rawPlanId is int
          ? rawPlanId
          : int.tryParse(rawPlanId?.toString() ?? ''),
    );
  }
}
