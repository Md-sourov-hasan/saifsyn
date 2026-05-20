import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @loginScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Thari Finance'**
  String get loginScreenTitle;

  /// No description provided for @loginScreenTitleAr.
  ///
  /// In en, this message translates to:
  /// **'ثري المالية'**
  String get loginScreenTitleAr;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @loginToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Log in to access your dashboard.'**
  String get loginToDashboard;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get orLoginWith;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Doesn\'t have account on dicover?'**
  String get noAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get nameHint;

  /// No description provided for @emailHintSignUp.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get emailHintSignUp;

  /// No description provided for @passwordHintSignUp.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordHintSignUp;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @createAccountFree.
  ///
  /// In en, this message translates to:
  /// **'Create your free account and start tracking up to 3 stocks.'**
  String get createAccountFree;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Info@gmail.com'**
  String get forgotPasswordHint;

  /// No description provided for @requestCode.
  ///
  /// In en, this message translates to:
  /// **'Request code'**
  String get requestCode;

  /// No description provided for @forgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone we will send the verification code to reset your password'**
  String get forgotPasswordMessage;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'verification Code'**
  String get otpVerificationTitle;

  /// No description provided for @otpVerificationMessage.
  ///
  /// In en, this message translates to:
  /// **'A verification code has been sent to your mail.'**
  String get otpVerificationMessage;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @tapToResend.
  ///
  /// In en, this message translates to:
  /// **'Tap to resend'**
  String get tapToResend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep your account secure by creating a strong password'**
  String get resetPasswordMessage;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordHint;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your new password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordHintText.
  ///
  /// In en, this message translates to:
  /// **'Your password should be at least contain upper character'**
  String get passwordHintText;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get createNewPassword;

  /// No description provided for @signUpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Successfully created an account'**
  String get signUpSuccessTitle;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'YOUR ACCOUNT HAS BEEN SUCCESSFULLY CREATED. YOU CAN NOW CONTINUE.'**
  String get signUpSuccessMessage;

  /// No description provided for @letsExplore.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Explore'**
  String get letsExplore;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'hyalurin.com'**
  String get poweredBy;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectLanguageAr.
  ///
  /// In en, this message translates to:
  /// **'اختر اللغة'**
  String get selectLanguageAr;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Halal Investing Made Easy'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'Track Sharia-compliant stocks with confidence.'**
  String get onboardingDescription1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Smart Portfolio Management'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDescription2.
  ///
  /// In en, this message translates to:
  /// **'Manage your investments with powerful tools.'**
  String get onboardingDescription2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Market Updates'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDescription3.
  ///
  /// In en, this message translates to:
  /// **'Stay informed with live market data and insights.'**
  String get onboardingDescription3;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'Invest Smarter. Invest Halal.'**
  String get splashTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sharia-compliant investing made simple.'**
  String get splashSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @noStocksFound.
  ///
  /// In en, this message translates to:
  /// **'No stocks found'**
  String get noStocksFound;

  /// No description provided for @halal.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get halal;

  /// No description provided for @lowRisk.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get lowRisk;

  /// No description provided for @doubtful.
  ///
  /// In en, this message translates to:
  /// **'Doubtful'**
  String get doubtful;

  /// No description provided for @highRisk.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get highRisk;

  /// No description provided for @welcomeBackHome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBackHome;

  /// No description provided for @eliteMember.
  ///
  /// In en, this message translates to:
  /// **'Elite Member'**
  String get eliteMember;

  /// No description provided for @allFeaturesUnlocked.
  ///
  /// In en, this message translates to:
  /// **'All features unlocked'**
  String get allFeaturesUnlocked;

  /// No description provided for @subscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get subscribed;

  /// No description provided for @upgradeToElite.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Elite'**
  String get upgradeToElite;

  /// No description provided for @unlockAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features and insights'**
  String get unlockAllFeatures;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @searchStocks.
  ///
  /// In en, this message translates to:
  /// **'Search Stocks....'**
  String get searchStocks;

  /// No description provided for @myRecommendations.
  ///
  /// In en, this message translates to:
  /// **'My Recommendations'**
  String get myRecommendations;

  /// No description provided for @viewCuratedPortfolios.
  ///
  /// In en, this message translates to:
  /// **'View Curated Portfolios'**
  String get viewCuratedPortfolios;

  /// No description provided for @trackedStocks.
  ///
  /// In en, this message translates to:
  /// **'Tracked Stocks'**
  String get trackedStocks;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @marketHighlights.
  ///
  /// In en, this message translates to:
  /// **'Market Highlights'**
  String get marketHighlights;

  /// No description provided for @topGainer.
  ///
  /// In en, this message translates to:
  /// **'Top Gainer'**
  String get topGainer;

  /// No description provided for @topLoser.
  ///
  /// In en, this message translates to:
  /// **'Top Loser'**
  String get topLoser;

  /// No description provided for @relatedNews.
  ///
  /// In en, this message translates to:
  /// **'Related News'**
  String get relatedNews;

  /// No description provided for @newsTitle1.
  ///
  /// In en, this message translates to:
  /// **'Apple Inc. Reports Strong Quarterly Earnings'**
  String get newsTitle1;

  /// No description provided for @newsTime1.
  ///
  /// In en, this message translates to:
  /// **'3 hours ago'**
  String get newsTime1;

  /// No description provided for @newsTitle2.
  ///
  /// In en, this message translates to:
  /// **'Analyst Upgrades Stock to Buy Rating'**
  String get newsTitle2;

  /// No description provided for @newsTime2.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get newsTime2;

  /// No description provided for @newsTitle3.
  ///
  /// In en, this message translates to:
  /// **'New Product Launch Announced'**
  String get newsTitle3;

  /// No description provided for @newsTime3.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get newsTime3;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @stocks.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocks;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @economic.
  ///
  /// In en, this message translates to:
  /// **'Economic'**
  String get economic;

  /// No description provided for @stockMarket.
  ///
  /// In en, this message translates to:
  /// **'Stock Market'**
  String get stockMarket;

  /// No description provided for @crypto.
  ///
  /// In en, this message translates to:
  /// **'Crypto'**
  String get crypto;

  /// No description provided for @newsTime_2hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'2 hours ago'**
  String get newsTime_2hoursAgo;

  /// No description provided for @newsTitle_fedMaintainsRates.
  ///
  /// In en, this message translates to:
  /// **'Fed Maintains Interest Rates at 5.25-5.50%'**
  String get newsTitle_fedMaintainsRates;

  /// No description provided for @newsDescription_fedMaintainsRates.
  ///
  /// In en, this message translates to:
  /// **'Federal Reserve holds rates steady amid cooling inflation'**
  String get newsDescription_fedMaintainsRates;

  /// No description provided for @newsTime_4hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'4 hours ago'**
  String get newsTime_4hoursAgo;

  /// No description provided for @newsTitle_techGiantsLead.
  ///
  /// In en, this message translates to:
  /// **'Tech Giants Lead Market Rally'**
  String get newsTitle_techGiantsLead;

  /// No description provided for @newsDescription_techGiantsLead.
  ///
  /// In en, this message translates to:
  /// **'Apple, Microsoft, and NVIDIA see significant gains'**
  String get newsDescription_techGiantsLead;

  /// No description provided for @newsTime_6hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'6 hours ago'**
  String get newsTime_6hoursAgo;

  /// No description provided for @newsTitle_bitcoinSurges.
  ///
  /// In en, this message translates to:
  /// **'Bitcoin Surges Past \$67,000'**
  String get newsTitle_bitcoinSurges;

  /// No description provided for @newsDescription_bitcoinSurges.
  ///
  /// In en, this message translates to:
  /// **'Cryptocurrency market sees renewed investor interest'**
  String get newsDescription_bitcoinSurges;

  /// No description provided for @newsTime_8hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'8 hours ago'**
  String get newsTime_8hoursAgo;

  /// No description provided for @newsTitle_globalTradeSlows.
  ///
  /// In en, this message translates to:
  /// **'Global Trade Growth Slows'**
  String get newsTitle_globalTradeSlows;

  /// No description provided for @newsDescription_globalTradeSlows.
  ///
  /// In en, this message translates to:
  /// **'International trade volume down 2% this quarter'**
  String get newsDescription_globalTradeSlows;

  /// No description provided for @newsTime_10hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'10 hours ago'**
  String get newsTime_10hoursAgo;

  /// No description provided for @newsTitle_energyHeadwinds.
  ///
  /// In en, this message translates to:
  /// **'Energy Sector Faces Headwinds'**
  String get newsTitle_energyHeadwinds;

  /// No description provided for @newsDescription_energyHeadwinds.
  ///
  /// In en, this message translates to:
  /// **'Oil prices decline on oversupply concerns'**
  String get newsDescription_energyHeadwinds;

  /// No description provided for @noNewsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No news in this category'**
  String get noNewsInCategory;

  /// No description provided for @latestNews.
  ///
  /// In en, this message translates to:
  /// **'Latest News'**
  String get latestNews;

  /// No description provided for @newsHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the most recent news and important updates.'**
  String get newsHeaderDescription;

  /// No description provided for @stockAlert_AAPL_title.
  ///
  /// In en, this message translates to:
  /// **'Stock Alert: AAPL'**
  String get stockAlert_AAPL_title;

  /// No description provided for @stockAlert_AAPL_message.
  ///
  /// In en, this message translates to:
  /// **'Apple stock increased by 3.2% today'**
  String get stockAlert_AAPL_message;

  /// No description provided for @time_1hourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get time_1hourAgo;

  /// No description provided for @marketNews_title.
  ///
  /// In en, this message translates to:
  /// **'Market News'**
  String get marketNews_title;

  /// No description provided for @marketNews_message.
  ///
  /// In en, this message translates to:
  /// **'Fed maintains interest rates at 5.25-5.50%'**
  String get marketNews_message;

  /// No description provided for @subscriptionReminder_title.
  ///
  /// In en, this message translates to:
  /// **'Subscription Reminder'**
  String get subscriptionReminder_title;

  /// No description provided for @subscriptionReminder_message.
  ///
  /// In en, this message translates to:
  /// **'Your premium subscription will renew in 7 days'**
  String get subscriptionReminder_message;

  /// No description provided for @time_1dayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get time_1dayAgo;

  /// No description provided for @newMessage_title.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get newMessage_title;

  /// No description provided for @newMessage_message.
  ///
  /// In en, this message translates to:
  /// **'Support team replied to your inquiry'**
  String get newMessage_message;

  /// No description provided for @time_2daysAgo.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get time_2daysAgo;

  /// No description provided for @stockAlert_TSLA_title.
  ///
  /// In en, this message translates to:
  /// **'Stock Alert: TSLA'**
  String get stockAlert_TSLA_title;

  /// No description provided for @stockAlert_TSLA_message.
  ///
  /// In en, this message translates to:
  /// **'Tesla stock reached your target price of \$250'**
  String get stockAlert_TSLA_message;

  /// No description provided for @time_3daysAgo.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get time_3daysAgo;

  /// No description provided for @cryptoMarketUpdate_title.
  ///
  /// In en, this message translates to:
  /// **'Crypto Market Update'**
  String get cryptoMarketUpdate_title;

  /// No description provided for @cryptoMarketUpdate_message.
  ///
  /// In en, this message translates to:
  /// **'Bitcoin surges past \$67,000 mark'**
  String get cryptoMarketUpdate_message;

  /// No description provided for @time_4daysAgo.
  ///
  /// In en, this message translates to:
  /// **'4 days ago'**
  String get time_4daysAgo;

  /// No description provided for @clearAllNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotificationsTitle;

  /// No description provided for @clearAllNotificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all notifications?'**
  String get clearAllNotificationsMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @allNotificationsCleared.
  ///
  /// In en, this message translates to:
  /// **'All notifications cleared'**
  String get allNotificationsCleared;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'View all your recent alerts and updates.'**
  String get notificationsHeaderDescription;

  /// No description provided for @allNotifications.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allNotifications;

  /// No description provided for @unreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unreadNotifications;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get buy;

  /// No description provided for @hold.
  ///
  /// In en, this message translates to:
  /// **'HOLD'**
  String get hold;

  /// No description provided for @priceAction.
  ///
  /// In en, this message translates to:
  /// **'PRICE ACTION'**
  String get priceAction;

  /// No description provided for @portfolioStocks.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Stocks'**
  String get portfolioStocks;

  /// No description provided for @portfolioHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'View and track stocks in your portfolio.'**
  String get portfolioHeaderDescription;

  /// No description provided for @searchPortfolioStocks.
  ///
  /// In en, this message translates to:
  /// **'Search Portfolio Stocks....'**
  String get searchPortfolioStocks;

  /// No description provided for @keyLevels.
  ///
  /// In en, this message translates to:
  /// **'KEY LEVELS'**
  String get keyLevels;

  /// No description provided for @resistance.
  ///
  /// In en, this message translates to:
  /// **'Resistance'**
  String get resistance;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'SELL'**
  String get sell;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @replyTo.
  ///
  /// In en, this message translates to:
  /// **'Reply to'**
  String get replyTo;

  /// No description provided for @writeYourReply.
  ///
  /// In en, this message translates to:
  /// **'Write your reply...'**
  String get writeYourReply;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @typeAComment.
  ///
  /// In en, this message translates to:
  /// **'Type a Comment.....'**
  String get typeAComment;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @buySellZones.
  ///
  /// In en, this message translates to:
  /// **'Buy / Sell Zones'**
  String get buySellZones;

  /// No description provided for @updatesEvery5m.
  ///
  /// In en, this message translates to:
  /// **'Updates every 5m'**
  String get updatesEvery5m;

  /// No description provided for @sellZone.
  ///
  /// In en, this message translates to:
  /// **'SELL ZONE'**
  String get sellZone;

  /// No description provided for @buyZone.
  ///
  /// In en, this message translates to:
  /// **'BUY ZONE'**
  String get buyZone;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @updatePasswordHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Update your password to keep your account secure.'**
  String get updatePasswordHeaderDescription;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @emailSettings.
  ///
  /// In en, this message translates to:
  /// **'Email Settings'**
  String get emailSettings;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Thari Finance. All rights reserved.'**
  String get copyright;

  /// No description provided for @pleaseEnterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get pleaseEnterCurrentPassword;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @pleaseConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get pleaseConfirmNewPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your password has been updated successfully.'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPasswordLabel;

  /// No description provided for @currentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get currentPasswordHint;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @selectYourDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get selectYourDateOfBirth;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @tellUsAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutYourself;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @infoNoteMessage.
  ///
  /// In en, this message translates to:
  /// **'Changes to your profile will be visible to your followers. Please ensure your information is accurate.'**
  String get infoNoteMessage;

  /// No description provided for @changePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhotoTitle;

  /// No description provided for @changePhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose a new profile photo from camera or gallery.'**
  String get changePhotoMessage;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your profile has been updated successfully.'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @changePhotoInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap to change photo'**
  String get changePhotoInstruction;

  /// No description provided for @passwordRequirementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Requirements:'**
  String get passwordRequirementsTitle;

  /// No description provided for @passwordMin8.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters long'**
  String get passwordMin8;

  /// No description provided for @passwordMustContainUppercase.
  ///
  /// In en, this message translates to:
  /// **'Include at least one uppercase letter'**
  String get passwordMustContainUppercase;

  /// No description provided for @passwordMustContainLowercase.
  ///
  /// In en, this message translates to:
  /// **'Include at least one lowercase letter'**
  String get passwordMustContainLowercase;

  /// No description provided for @passwordMustContainUppercaseLowercase.
  ///
  /// In en, this message translates to:
  /// **'Mix of uppercase and lowercase letters'**
  String get passwordMustContainUppercaseLowercase;

  /// No description provided for @passwordMustContainNumber.
  ///
  /// In en, this message translates to:
  /// **'Include at least one number'**
  String get passwordMustContainNumber;

  /// No description provided for @passwordMustContainSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Include at least one special character'**
  String get passwordMustContainSpecialChar;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @opportunityStocks.
  ///
  /// In en, this message translates to:
  /// **'Opportunity\nStocks'**
  String get opportunityStocks;

  /// No description provided for @commodities.
  ///
  /// In en, this message translates to:
  /// **'Commodities'**
  String get commodities;

  /// No description provided for @cryptoTracking.
  ///
  /// In en, this message translates to:
  /// **'Crypto\nTracking'**
  String get cryptoTracking;

  /// No description provided for @budgetManager.
  ///
  /// In en, this message translates to:
  /// **'Budget\nManager'**
  String get budgetManager;

  /// No description provided for @goalsTracking.
  ///
  /// In en, this message translates to:
  /// **'Goals\nTracking'**
  String get goalsTracking;

  /// No description provided for @directSupport.
  ///
  /// In en, this message translates to:
  /// **'Direct\nSupport'**
  String get directSupport;

  /// No description provided for @analystRatingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyst\'s Ratings'**
  String get analystRatingsTitle;

  /// No description provided for @analystRatingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on 26 analysts giving stock ratings to this stock in the past 3 months'**
  String get analystRatingsSubtitle;

  /// No description provided for @strongBuy.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY'**
  String get strongBuy;

  /// No description provided for @strongSell.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL'**
  String get strongSell;

  /// No description provided for @notHalal.
  ///
  /// In en, this message translates to:
  /// **'Not Halal'**
  String get notHalal;

  /// No description provided for @halalTab.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get halalTab;

  /// No description provided for @forecastTab.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get forecastTab;

  /// No description provided for @analysisTab.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysisTab;

  /// No description provided for @financialsTab.
  ///
  /// In en, this message translates to:
  /// **'Financials'**
  String get financialsTab;

  /// No description provided for @halalComplianceDescription.
  ///
  /// In en, this message translates to:
  /// **'This chart shows the breakdown of halal compliance classifications for this stock.'**
  String get halalComplianceDescription;

  /// No description provided for @allRisk.
  ///
  /// In en, this message translates to:
  /// **'All Risk'**
  String get allRisk;

  /// No description provided for @mediumRisk.
  ///
  /// In en, this message translates to:
  /// **'Medium Risk'**
  String get mediumRisk;

  /// No description provided for @browseStocks.
  ///
  /// In en, this message translates to:
  /// **'Browse Stocks'**
  String get browseStocks;

  /// No description provided for @calculation.
  ///
  /// In en, this message translates to:
  /// **'Calculation'**
  String get calculation;

  /// No description provided for @detailedReport.
  ///
  /// In en, this message translates to:
  /// **'Detailed Report'**
  String get detailedReport;

  /// No description provided for @businessActivity.
  ///
  /// In en, this message translates to:
  /// **'Business Activity'**
  String get businessActivity;

  /// No description provided for @interestBearing.
  ///
  /// In en, this message translates to:
  /// **'Interest-bearing'**
  String get interestBearing;

  /// No description provided for @interestBearingDebt.
  ///
  /// In en, this message translates to:
  /// **'Interest-bearing debt'**
  String get interestBearingDebt;

  /// No description provided for @shariahCompliant.
  ///
  /// In en, this message translates to:
  /// **'Shariah-compliant'**
  String get shariahCompliant;

  /// No description provided for @lessThan30.
  ///
  /// In en, this message translates to:
  /// **'Less than 30%'**
  String get lessThan30;

  /// No description provided for @nonShariahCompliant.
  ///
  /// In en, this message translates to:
  /// **'Non-shariah compliant'**
  String get nonShariahCompliant;

  /// No description provided for @greaterThan30.
  ///
  /// In en, this message translates to:
  /// **'Greater than 30%'**
  String get greaterThan30;

  /// No description provided for @interestBearingDescription.
  ///
  /// In en, this message translates to:
  /// **'Total amount of interest-bearing securities and assets should not exceed 30% of the market capitalization to be Shariah compliant.'**
  String get interestBearingDescription;

  /// No description provided for @perShareData.
  ///
  /// In en, this message translates to:
  /// **'Per Share Data'**
  String get perShareData;

  /// No description provided for @ratios.
  ///
  /// In en, this message translates to:
  /// **'Ratios'**
  String get ratios;

  /// No description provided for @statements.
  ///
  /// In en, this message translates to:
  /// **'Statements'**
  String get statements;

  /// No description provided for @revenuePerShare.
  ///
  /// In en, this message translates to:
  /// **'Revenue per Share (TTM)'**
  String get revenuePerShare;

  /// No description provided for @ebitPerShare.
  ///
  /// In en, this message translates to:
  /// **'EBIT per Share (TTM)'**
  String get ebitPerShare;

  /// No description provided for @earningsPerShare.
  ///
  /// In en, this message translates to:
  /// **'Earnings per Share (EPS) (TTM)'**
  String get earningsPerShare;

  /// No description provided for @dividendPerShare.
  ///
  /// In en, this message translates to:
  /// **'Dividend per Share (TTM)'**
  String get dividendPerShare;

  /// No description provided for @epsForward.
  ///
  /// In en, this message translates to:
  /// **'EPS Forward'**
  String get epsForward;

  /// No description provided for @currencyUsd.
  ///
  /// In en, this message translates to:
  /// **'Currency (USD)'**
  String get currencyUsd;

  /// No description provided for @year2025.
  ///
  /// In en, this message translates to:
  /// **'2025'**
  String get year2025;

  /// No description provided for @managePlansBilling.
  ///
  /// In en, this message translates to:
  /// **'Manage your plans and billing details.'**
  String get managePlansBilling;

  /// No description provided for @chooseYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get chooseYourPlan;

  /// No description provided for @plan_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get plan_monthly;

  /// No description provided for @plan_6_months.
  ///
  /// In en, this message translates to:
  /// **'6 Months'**
  String get plan_6_months;

  /// No description provided for @plan_12_months.
  ///
  /// In en, this message translates to:
  /// **'12 Months'**
  String get plan_12_months;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @eliteFeatures.
  ///
  /// In en, this message translates to:
  /// **'Elite Features'**
  String get eliteFeatures;

  /// No description provided for @elite_feature_opportunity_stocks.
  ///
  /// In en, this message translates to:
  /// **'Opportunity stocks with growth potential'**
  String get elite_feature_opportunity_stocks;

  /// No description provided for @elite_feature_commodities.
  ///
  /// In en, this message translates to:
  /// **'Commodities tracking (Gold, Oil, Silver)'**
  String get elite_feature_commodities;

  /// No description provided for @elite_feature_crypto.
  ///
  /// In en, this message translates to:
  /// **'Cryptocurrency market insights'**
  String get elite_feature_crypto;

  /// No description provided for @elite_feature_budget.
  ///
  /// In en, this message translates to:
  /// **'Personal budget & expense manager'**
  String get elite_feature_budget;

  /// No description provided for @elite_feature_goals.
  ///
  /// In en, this message translates to:
  /// **'Financial goals tracking'**
  String get elite_feature_goals;

  /// No description provided for @elite_feature_analysts.
  ///
  /// In en, this message translates to:
  /// **'Direct communication with analysts'**
  String get elite_feature_analysts;

  /// No description provided for @confirmSubscription.
  ///
  /// In en, this message translates to:
  /// **'Confirm Subscription'**
  String get confirmSubscription;

  /// No description provided for @subscribeTo.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to'**
  String get subscribeTo;

  /// No description provided for @planQuestionSuffix.
  ///
  /// In en, this message translates to:
  /// **'plan?'**
  String get planQuestionSuffix;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @alreadySubscribed.
  ///
  /// In en, this message translates to:
  /// **'Already Subscribed'**
  String get alreadySubscribed;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get subscribeNow;

  /// No description provided for @cancelAnytimeNoQuestions.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. No questions asked.'**
  String get cancelAnytimeNoQuestions;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'Important:'**
  String get important;

  /// No description provided for @subscriptionInfoText.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever'**
  String get subscriptionInfoText;

  /// No description provided for @subscription_activated.
  ///
  /// In en, this message translates to:
  /// **'Subscription activated! You are now an Elite Member.'**
  String get subscription_activated;

  /// No description provided for @subscription_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Subscription cancelled successfully.'**
  String get subscription_cancelled;

  /// No description provided for @failed_activate_subscription.
  ///
  /// In en, this message translates to:
  /// **'Failed to activate subscription. Please try again.'**
  String get failed_activate_subscription;

  /// No description provided for @failed_cancel_subscription.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel subscription. Please try again.'**
  String get failed_cancel_subscription;

  /// No description provided for @goElite.
  ///
  /// In en, this message translates to:
  /// **'Go Elite'**
  String get goElite;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
