import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;
  static int() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putdata(
      {@required String key, @required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    if (value is bool)
      return await sharedPreferences.setBool(key, value);
    else
      return await sharedPreferences.setInt(key, value);
  }

  static dynamic getKey({@required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeKey({@required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
