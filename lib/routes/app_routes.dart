import 'package:get/get.dart';
import 'package:saifsyn/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:saifsyn/features/onboarding/presentation/screens/language_selection_screen.dart';
import 'package:saifsyn/features/onboarding/presentation/screens/onboarding_pages.dart';
import 'package:saifsyn/features/authentication/presentation/screens/login_screen.dart';
import 'package:saifsyn/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:saifsyn/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:saifsyn/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:saifsyn/features/authentication/presentation/screens/signup_screen.dart';
import 'package:saifsyn/features/authentication/presentation/screens/signup_success_screen.dart';
import 'package:saifsyn/features/main/presentation/screens/main_navigation_screen.dart';
import 'package:saifsyn/features/stocks/presentation/screens/stock_details_screen.dart';
import 'package:saifsyn/features/portfolios/presentation/screens/portfolio_stock_details_screen.dart';
import 'package:saifsyn/features/profile/presentation/screens/terms_conditions_screen.dart';
import 'package:saifsyn/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:saifsyn/features/profile/presentation/screens/email_settings_screen.dart';
import 'package:saifsyn/features/profile/presentation/screens/contact_us_screen.dart';
import 'package:saifsyn/features/profile/presentation/screens/about_us_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String languageSelectionScreen = "/languageSelectionScreen";
  static String onBoardingScreen = "/onBoardingScreen";
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String signUpSuccessScreen = "/signUpSuccessScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpVerificationScreen = "/otpVerificationScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String mainNavigationScreen = "/mainNavigationScreen";
  static String stockDetailsScreen = "/stock-details";
  static String portfolioStockDetailsScreen = "/portfolio-stock-details";
  static String termsConditionsScreen = "/terms-conditions";
  static String privacyPolicyScreen = "/privacy-policy";
  static String emailSettingsScreen = "/email-settings";
  static String contactUsScreen = "/contact-us";
  static String aboutUsScreen = "/about-us";

  static String getSplashScreen() => splashScreen;
  static String getLanguageSelectionScreen() => languageSelectionScreen;
  static String getOnBoardingScreen() => onBoardingScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getSignUpSuccessScreen() => signUpSuccessScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getOtpVerificationScreen() => otpVerificationScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getMainNavigationScreen() => mainNavigationScreen;
  static String getStockDetailsScreen() => stockDetailsScreen;
  static String getPortfolioStockDetailsScreen() => portfolioStockDetailsScreen;
  static String getTermsConditionsScreen() => termsConditionsScreen;
  static String getPrivacyPolicyScreen() => privacyPolicyScreen;
  static String getEmailSettingsScreen() => emailSettingsScreen;
  static String getContactUsScreen() => contactUsScreen;
  static String getAboutUsScreen() => aboutUsScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: languageSelectionScreen,
      page: () => const LanguageSelectionScreen(),
    ),
    GetPage(
      name: onBoardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: signUpSuccessScreen,
      page: () => const SignUpSuccessScreen(),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: mainNavigationScreen,
      page: () => const MainNavigationScreen(),
    ),
    GetPage(
      name: stockDetailsScreen,
      page: () => const StockDetailsScreen(),
    ),
    GetPage(
      name: portfolioStockDetailsScreen,
      page: () => const PortfolioStockDetailsScreen(),
    ),
    GetPage(
      name: termsConditionsScreen,
      page: () => const TermsConditionsScreen(),
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: emailSettingsScreen,
      page: () => const EmailSettingsScreen(),
    ),
    GetPage(
      name: contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: aboutUsScreen,
      page: () => const AboutUsScreen(),
    ),
  ];
}
