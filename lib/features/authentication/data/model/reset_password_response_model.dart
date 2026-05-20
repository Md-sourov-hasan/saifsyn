class ResetPasswordResponseModel {
  final bool success;
  final String message;

  ResetPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return ResetPasswordResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
    );
  }
}
