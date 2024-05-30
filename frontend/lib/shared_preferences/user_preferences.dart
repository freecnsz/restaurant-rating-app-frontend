import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyId = 'id';
  static const _placeId = 'placeId';
  static const _cityId = 'cityId';

  static Future<void> saveUserInfo(
      String username, String email, String id, int placeId, int cityId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyId, id);
    await prefs.setInt(_placeId, placeId);
    await prefs.setInt(_cityId, cityId);
  }

  static Future<Map<String, String?>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString(_keyUsername);
    final String? email = prefs.getString(_keyEmail);
    final String? id = prefs.getString(_keyId);
    return {
      'username': username,
      'email': email,
      'id': id,
      'placeId': prefs.getInt(_placeId).toString(),
      'cityId': prefs.getInt(_cityId).toString(),
    };
  }

  static Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyId);
    await prefs.remove(_placeId);
    await prefs.remove(_cityId);
  }
}
