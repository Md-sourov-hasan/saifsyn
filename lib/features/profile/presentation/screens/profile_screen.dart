import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/features/myanalysis/screen/my_analysis_screen.dart';
import 'package:saifsyn/routes/app_routes.dart';
import 'package:saifsyn/features/authentication/controllers/login_controller.dart';
import 'package:saifsyn/features/profile/controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/logout_button.dart';
import '../widgets/premium_features_card.dart';
import 'edit_profile_screen.dart';
import 'email_settings_screen.dart';
import 'change_password_screen.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';
import 'contact_us_screen.dart';
import 'about_us_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../massages/presentation/massages.dart';
import '../../../subscription/presentation/screens/subscription_screen.dart';
import '../../../subscription/controllers/subscription_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionController = Get.find<SubscriptionController>();
    final localizationService = Get.find<LocalizationService>();
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with profile info
              Obx(() {
                final profile = profileController.profileData;
                final username = (profile?.name ?? '').trim().isNotEmpty
                    ? profile!.name
                    : 'User';
                final email = (profile?.email ?? '').trim().isNotEmpty
                    ? profile!.email
                    : 'No email available';
                final isEliteMember = profile?.isEliteMember ??
                    subscriptionController.isEliteMember;

                return ProfileHeader(
                  username: username,
                  email: email,
                  isEliteMember: isEliteMember,
                  planName: profile?.planName,
                  onUpgradeTap: () {
                    Get.to(() => const SubscriptionScreen());
                  },
                );
              }),

              SizedBox(height: 19.h),

              // Premium Features Card (only show if elite member)
              Obx(() {
                final profile = profileController.profileData;
                final isEliteMember = profile?.isEliteMember ??
                    subscriptionController.isEliteMember;

                if (isEliteMember) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: const PremiumFeaturesCard(),
                      ),
                      SizedBox(height: 19.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),

              // Account settings section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ProfileMenuSection(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.notifications_outlined,
                      title: localizationService.translate('notifications'),
                      badgeCount: 2,
                      onTap: () {
                        Get.to(() => const NotificationsScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.mark_chat_unread_outlined,
                      title: 'Massages',
                      onTap: () {
                        Get.to(() => const MassagesScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: localizationService.translate('editProfile'),
                      onTap: () {
                        Get.to(() => const EditProfileScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.email_outlined,
                      title: localizationService.translate('emailSettings'),
                      onTap: () {
                        Get.to(() => const EmailSettingsScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.lock_outline,
                      title: localizationService.translate('changePassword'),
                      onTap: () {
                        Get.to(() => const ChangePasswordScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.trending_up,
                      title: localizationService.translate('My Analysis'),
                      onTap: () {
                        Get.to(() => const MyAnalysisScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.subscriptions_outlined,
                      title: localizationService.translate('subscription'),
                      showBorder: false,
                      onTap: () {
                        Get.to(() => const SubscriptionScreen());
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 19.h),

              // Legal section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ProfileMenuSection(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.description_outlined,
                      title:
                          localizationService.translate('termsAndConditions'),
                      onTap: () {
                        Get.to(() => const TermsConditionsScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: localizationService.translate('privacyPolicy'),
                      showBorder: true,
                      onTap: () {
                        Get.to(() => const PrivacyPolicyScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.contact_page_outlined,
                      title: localizationService.translate('ContactUs'),
                      showBorder: true,
                      onTap: () {
                        Get.to(() => const ContactUsScreen());
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.group_outlined,
                      title: localizationService.translate('aboutUs'),
                      showBorder: false,
                      onTap: () {
                        Get.to(() => const AboutUsScreen());
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 39.h),

              // Logout button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: LogoutButton(
                  onTap: () {
                    // TODO: Show logout confirmation dialog
                    Get.dialog(
                      AlertDialog(
                        title: Text(localizationService.translate('logout')),
                        content: Text(localizationService
                            .translate('logoutConfirmation')),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child:
                                Text(localizationService.translate('cancel')),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              await StorageService.logoutUser();
                              if (Get.isRegistered<LoginController>()) {
                                Get.delete<LoginController>(force: true);
                              }
                              Get.offAllNamed(AppRoute.getLoginScreen());
                            },
                            child: Text(
                              localizationService.translate('logout'),
                              style: const TextStyle(color: Color(0xFFE7000B)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Footer
              Text(
                localizationService.translate('copyright'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF697282),
                  fontSize: 14.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
