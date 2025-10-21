import 'package:shared_preferences/shared_preferences.dart';
import 'package:slot_booking_app/utils/sp_keys.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  /// INITIALIZR SHARED PREF MANAGER
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// USER TOKEN
  static String? getUserToken() {
    return _preferences?.getString(SPKeys.userToken);
  }

  static Future<bool> setUserToken(String value) async {
    return await _preferences?.setString(SPKeys.userToken, value) ??
        Future.value(false);
  }

  static Future<bool> clearUserToken() async {
    return await _preferences?.setString(SPKeys.userToken, "") ??
        Future.value(false);
  }
}
