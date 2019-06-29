import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager{
  static SharedPreferences prefs;

  static Future<String> getStringValue(String key) async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    }else{
      return prefs.getString(key);
    }
  }
  static Future<int> getIntValue(String key) async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs.getInt(key);
    }else{
      return prefs.getInt(key);
    }
  }

  static Future<void> storeStringValue(String key, String data) async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, data);
    }else{
      await prefs.setString(key, data);
    }
  }
  static Future<void> storeIntValue(String key, int data) async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, data);
    }else{
      await prefs.setInt(key, data);
    }
  }
}