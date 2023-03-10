import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {

  ///Check if is it the first time the user uses the app
  static Future<bool?> checkHasOpened() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("has_opened");
  }

  ///Set if user open app for the first time
  static Future<void> setHasOpened(bool value) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("has_opened", value);
  }

  ///Get user token
  static Future<String?> getUserToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("user");
  }

  ///Set User token
  static Future<void> setUserToken(String value) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("user", value);
  }

  ///Remose User token
  static Future<void> removeUserToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove("user");
  }

  ///Get user locale setting
  static Future<String?> getUserLocale() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("locale");
  }

  ///Set user locale setting
  static Future<void> setUserLocale(String lang) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("locale", lang);
  }
}