import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';

  // Singleton instance for SharedPreferences
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null;
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id);
  }

  // Save login credentials and user profile details.
  static Future<void> saveLoginCredentials({
    required String email,
    required String password,
  }) async {
    await _preferences?.setString(_emailKey, email);
    await _preferences?.setString(_passwordKey, password);
  }

  // Remove the token and user ID from local storage (for logout)
  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_idKey);
    await _preferences?.remove(_emailKey);
    await _preferences?.remove(_passwordKey);
    // Navigate to the login screen
    // Get.offAllNamed('/login');
  }

  // Getter for user ID
  static String? get userId => _preferences?.getString(_idKey);

  // Getter for token
  static String? get token => _preferences?.getString(_tokenKey);

  // Async getter for token with lazy SharedPreferences initialization.
  static Future<String?> getTokenValue() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences?.getString(_tokenKey);
  }

  // Async getter for user ID with lazy SharedPreferences initialization.
  static Future<String?> getUserIdValue() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences?.getString(_idKey);
  }

  // Getter for stored email
  static String? get email => _preferences?.getString(_emailKey);

  // Getter for stored password
  static String? get password => _preferences?.getString(_passwordKey);
}
