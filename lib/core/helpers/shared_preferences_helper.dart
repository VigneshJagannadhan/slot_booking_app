import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slot_booking_app/utils/sp_keys.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;
  static FlutterSecureStorage? _secureStorage;

  /// INITIALIZE SHARED PREF MANAGER
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _secureStorage = FlutterSecureStorage();
  }

  /// USER TOKEN
  static Future<String?> getUserToken() async =>
      await _secureStorage?.read(key: SPKeys.userToken);

  static Future<void> setUserToken(String value) async =>
      await _secureStorage?.write(key: SPKeys.userToken, value: value);

  static Future<void> clearUserToken() async =>
      await _secureStorage?.delete(key: SPKeys.userToken);

  /// USER ROUTES
  static String? getUserRoute() {
    return _preferences?.getString(SPKeys.lastRoute);
  }

  static Future<bool> setUserRoute(String value) async {
    return await _preferences?.setString(SPKeys.lastRoute, value) ??
        Future.value(false);
  }

  static Future<bool> clearUserRoute() async {
    return await _preferences?.setString(SPKeys.lastRoute, "") ??
        Future.value(false);
  }
}
