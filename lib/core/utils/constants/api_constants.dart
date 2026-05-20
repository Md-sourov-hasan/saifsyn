class ApiConstants {
  // static const String baseUrl = 'http://103.174.189.183:8081/api/v1';
  static const String baseUrl = 'https://api.thari.finance/api/v1';
  static const String aiBaseUrl = 'https://ai.thari.finance/api/v1';

  // Authentication
  static const String register = '$baseUrl/register';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String login = '$baseUrl/login';
  static const String resendOtp = '$baseUrl/resend-otp';
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String fcmToken = '$baseUrl/fcm-token';

  // Subscription Plan
  static const String getAllSubscriptions = '$baseUrl/subscriptions/show-all';
  static String getSubscriptionById(int id) =>
      '$baseUrl/subscriptions/show/$id';
  static String updateSubscription(int id) => '$baseUrl/subscriptions/$id';
  static String deleteSubscription(int id) => '$baseUrl/subscriptions/$id';

  // Terms and Conditions
  static const String terms = '$baseUrl/terms';
  static const String acceptTerms = '$baseUrl/terms';

  // Zoya External API (internal proxy endpoints)
  static const String zoyaStock = '$baseUrl/zoya/stock';
  static const String zoyaReports = '$baseUrl/zoya/reports';
  static const String zoyaCompliantStocks = '$baseUrl/zoya/compliant-stocks';
  static const String zoyaAdvancedReport = '$baseUrl/zoya/advanced-report';
  static const String zoyaInternationalReport =
      '$baseUrl/zoya/international-report';
  static const String zoyaRegionalReports = '$baseUrl/zoya/regional-reports';
  static const String zoyaMenaScreens = '$baseUrl/zoya/mena-screens';
  static const String zoyaEtfReports = '$baseUrl/zoya/etf-reports';
  static const String zoyaRegions = '$baseUrl/zoya/regions';

  // Note: The actual Zoya GraphQL endpoint is external and not proxied through your base URL
  static const String zoyaGraphql = 'https://sandbox-api.zoya.finance/graphql';

  // Messaging
  static const String sendChat = '$baseUrl/chat/send';
  static String getChatByUserId(int userId) => '$baseUrl/chat/$userId';
  static String getConversation({
    required int senderId,
    required int receiverId,
  }) =>
      '$baseUrl/messages?sender_id=$senderId&receiver_id=$receiverId';

  // Stripe Payment System
  static const String processPayment = '$baseUrl/payment/process';
  static const String showPayment = '$baseUrl/payment/show';
  static const String getAllPayments = '$baseUrl/all-payments';

  // News
  static const String createNews = '$baseUrl/news';
  static const String getAllNews = '$baseUrl/news';
  static String updateNews(int id) => '$baseUrl/news/$id';
  static String deleteNews(int id) => '$baseUrl/news/$id';

  // User Profile
  static const String profile = '$baseUrl/profile';
  static const String updateProfile = '$baseUrl/profile';
  static const String changePassword = '$baseUrl/profile/password';

  // contact us
  static const String contact = '$baseUrl/contact';

  // about us
  static const String about = '$baseUrl/about';

  // our analysis
  static const String analyses = '$baseUrl/analyses';
  static const String companyAnalysis = '$aiBaseUrl/analysis/company';
  static String analysisHistory(String userId) =>
      '$aiBaseUrl/analysis/history/$userId';
  static String analysisResult(String id) => '$aiBaseUrl/analysis/result/$id';

  // Wishlist
  static const String wishlist = '$baseUrl/wishlist';
  static String wishlistById(int id) => '$wishlist/$id';

  // Notifications
  static const String bellNotifications = '$baseUrl/bell-notifications';
  static String markNotificationAsRead(int notificationId) =>
      '$baseUrl/notifications/read/$notificationId';

  // Financial Manager - Income
  static const String financialIncomes = '$baseUrl/financial/incomes';
  static String financialIncomeById(int id) => '$financialIncomes/$id';

  // Financial Manager - Expense
  static const String financialExpenses = '$baseUrl/financial/expenses';
  static String financialExpenseById(int id) => '$financialExpenses/$id';

  // Financial Manager - Loan
  static const String financialLoans = '$baseUrl/financial/loans';
  static String financialLoanById(int id) => '$financialLoans/$id';

  // AI Financial Dashboard
  static const String financialManagerShowAll = '$baseUrl/financial/manager';
  static const String financialWealth = '$baseUrl/financial/wealth';
  static const String financialLoanCalculation = '$baseUrl/financial/loan/calc';
}
