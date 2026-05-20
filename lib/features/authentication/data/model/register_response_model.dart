class RegisterResponseModel {
  final bool success;
  final String message;
  final RegisterData? data;

  RegisterResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return RegisterResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? RegisterData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class RegisterData {
  final int id;
  final String email;
  final String role;

  RegisterData({
    required this.id,
    required this.email,
    required this.role,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return RegisterData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }
}
