import 'dart:convert';
import 'dart:io';
import 'package:moddhobitto_mobile/constant/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SessionManager {
  // Yes, it uses SharedPreferences
  late final SharedPreferences _prefs;

  // Initialize the SharedPreferences instance
  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;

  // Getter and Setter for login
  get loggedIn => _prefs.getBool(keyIsUserLoggedIn) ?? false;

  set loggedIn(isLoggedIn) => _prefs.setBool(keyIsUserLoggedIn, isLoggedIn);

  // Getter and Setter for user id
  int get userId => _prefs.getInt(keyUserId) ?? 0;

  set userId(int userId) => _prefs.setInt(keyUserId, userId);

  // Getter and Setter for doctor id
  int get doctorId => _prefs.getInt(keyDoctorId) ?? 0;

  set doctorId(int doctorId) => _prefs.setInt(keyDoctorId, doctorId);

  // Getter and Setter for org id
  int get orgId => _prefs.getInt(keyOrgId) ?? 0;

  set orgId(int orgId) => _prefs.setInt(keyOrgId, orgId);

  Map<String, String> get httpHeaders => {'cookie': prefs.getString(keyCookie) ?? ''};

  /// Item setter
  ///
  /// @param key String
  /// @returns dynamic
  get(key) {
    try {
      return jsonDecode(_prefs.get(key) as String);
    } catch (_) {
      return _prefs.get(key);
    }
  }

  /// Item setter
  ///
  /// @param key String
  /// @param value any
  /// @returns dynamic
  set(key, value) {
    // Detect item type
    switch (value.runtimeType) {
      // String
      case String:
        _prefs.setString(key, value);
        break;

      // Integer
      case int:
        _prefs.setInt(key, value);
        break;

      // Boolean
      case bool:
        _prefs.setBool(key, value);
        break;

      // Double
      case double:
        _prefs.setDouble(key, value);
        break;

      // List<String>
      case List:
        _prefs.setStringList(key, value);
        break;

      // Object
      default:
        _prefs.setString(key, jsonEncode(value.toJson()));
        break;
    }
  }

  void clearSession() {
    _prefs.setInt(keyUserId, 0);
    _prefs.setString(keyAuthInfo, '');
  }
}

final prefManager = SessionManager();
