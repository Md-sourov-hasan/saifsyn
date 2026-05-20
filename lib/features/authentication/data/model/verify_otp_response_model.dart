class VerifyOtpResponseModel {
  final bool success;
  final String message;

  VerifyOtpResponseModel({
    required this.success,
    required this.message,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return VerifyOtpResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
    );
  }
}
