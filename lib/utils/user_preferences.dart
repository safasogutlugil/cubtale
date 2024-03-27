import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyCredentials = 'credentials';
  static const _keyTheme = 'theme';

  static Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setCredentials(String token, DateTime expiryDate) async {
    await _preferences.setString(_keyCredentials, token);
    await _preferences.setString('expiryDate', expiryDate.toIso8601String());
  }

  static String? getCredentials() {
    final expiryDateString = _preferences.getString('expiryDate');
    if (expiryDateString != null) {
      final expiryDate = DateTime.parse(expiryDateString);
      if (DateTime.now().isBefore(expiryDate)) {
        return _preferences.getString(_keyCredentials);
      }
    }
    return null;
  }

  static Future setThemePreference(String theme) async {
    await _preferences.setString(_keyTheme, theme);
  }

  static String? getThemePreference() {
    return _preferences.getString(_keyTheme);
  }

  static Future clearCredentials() async {
    await _preferences.remove(_keyCredentials);
    await _preferences.remove('expiryDate');
  }
}
