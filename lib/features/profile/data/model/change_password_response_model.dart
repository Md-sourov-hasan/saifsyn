class ChangePasswordResponseModel {
  final bool success;
  final String message;

  ChangePasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return ChangePasswordResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
    );
  }
}
