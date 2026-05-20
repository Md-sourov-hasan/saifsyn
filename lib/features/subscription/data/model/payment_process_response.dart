class PaymentProcessResponse {
  final bool success;
  final String checkoutUrl;
  final String? sessionId;
  final num? amount;

  PaymentProcessResponse({
    required this.success,
    required this.checkoutUrl,
    this.sessionId,
    this.amount,
  });

  factory PaymentProcessResponse.fromJson(Map<String, dynamic> json) {
    return PaymentProcessResponse(
      success: json['success'] == true,
      checkoutUrl: json['checkout_url']?.toString() ?? '',
      sessionId: json['session_id']?.toString(),
      amount: json['amount'] is num ? json['amount'] as num : null,
    );
  }
}
