class ProfileResponseModel {
  final bool success;
  final String message;
  final ProfileData? data;

  ProfileResponseModel({
    required this.success,
    this.message = '',
    this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return ProfileResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? ProfileData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ProfileData {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? phone;
  final String? fcmToken;
  final String? otpExpireAt;
  final bool status;
  final int termsAccepted;
  final int? subscriptionPlanId;
  final String? planName;
  final int isFirstTime;
  final String? createdAt;
  final String? updatedAt;
  final String role;

  bool get hasActiveSubscription {
    final normalizedPlanName = planName?.trim().toLowerCase() ?? '';
    return subscriptionPlanId != null ||
        (normalizedPlanName.isNotEmpty &&
            normalizedPlanName != 'free' &&
            normalizedPlanName != 'none' &&
            normalizedPlanName != 'null');
  }

  bool get isEliteMember => hasActiveSubscription;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.phone,
    this.fcmToken,
    this.otpExpireAt,
    required this.status,
    required this.termsAccepted,
    this.subscriptionPlanId,
    this.planName,
    required this.isFirstTime,
    this.createdAt,
    this.updatedAt,
    required this.role,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final termsAcceptedValue = json['terms_accepted'];
    final subscriptionPlanIdValue = json['subscription_plan_id'];
    final isFirstTimeValue = json['is_first_time'];

    return ProfileData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      emailVerifiedAt: json['email_verified_at']?.toString(),
      phone: json['phone']?.toString(),
      fcmToken: json['fcm_token']?.toString(),
      otpExpireAt: json['otp_expire_at']?.toString(),
      status: json['status'] == true || json['status']?.toString() == '1',
      termsAccepted: termsAcceptedValue is int
          ? termsAcceptedValue
          : int.tryParse(termsAcceptedValue.toString()) ?? 0,
      subscriptionPlanId: subscriptionPlanIdValue == null
          ? null
          : (subscriptionPlanIdValue is int
              ? subscriptionPlanIdValue
              : int.tryParse(subscriptionPlanIdValue.toString())),
      planName: json['plan_name']?.toString(),
      isFirstTime: isFirstTimeValue is int
          ? isFirstTimeValue
          : int.tryParse(isFirstTimeValue.toString()) ?? 0,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      role: json['role']?.toString() ?? '',
    );
  }
}
