import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String loginKey = "login";
  static const String tokenKey = "token";

  static void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?>? getToken() async {
    print(tokenKey);
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(tokenKey);
    return prefs.getString(tokenKey);
  }

  static void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
