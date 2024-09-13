import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? _sharedPreferences;

  static String userNameKey = "username";
  static String partyCodeKey = "partyCode";
  static String partyIdKey = "partyId";
  static String mobileKey = "mobile";
  static String emailKey = "email";
  static String isMPinSetKey ="isMPinSet";

  init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  clear() async {
    if (_sharedPreferences != null) {
      try {
        _sharedPreferences?.clear();
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
  }

  Future<void> delete(String key) async {
    try {
      await _sharedPreferences?.remove(key);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  setInt(String key, int value) {
    _sharedPreferences?.setInt(key, value);
  }

  setString(String key, String value) {
    _sharedPreferences?.setString(key, value);
  }

  setBool(String key, bool value) {
    _sharedPreferences?.setBool(key, value);
  }

  int getInt(String key)=>_sharedPreferences?.getInt(key)??-1;
  String? getString(String key)=> _sharedPreferences?.getString(key);
  bool? getBool(String key)=> _sharedPreferences?.getBool(key);

}
