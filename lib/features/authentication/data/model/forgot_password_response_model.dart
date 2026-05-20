class ForgotPasswordResponseModel {
  final bool success;
  final String message;

  ForgotPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return ForgotPasswordResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
    );
  }
}
