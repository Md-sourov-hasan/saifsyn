class LoginResponseModel {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return LoginResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LoginData {
  final LoginUser? user;
  final String token;
  final String tokenType;

  LoginData({
    this.user,
    required this.token,
    required this.tokenType,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] is Map<String, dynamic>
          ? LoginUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      token: json['token']?.toString() ?? '',
      tokenType: json['token_type']?.toString() ?? '',
    );
  }
}

class LoginUser {
  final int id;
  final String email;
  final String role;
  final dynamic planId;
  final dynamic planName;

  LoginUser({
    required this.id,
    required this.email,
    required this.role,
    this.planId,
    this.planName,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return LoginUser(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      planId: json['plan_id'],
      planName: json['plan_name'],
    );
  }
}
