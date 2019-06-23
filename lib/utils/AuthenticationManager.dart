import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager{
  static SharedPreferences prefs;

  static Future<String> getToken() async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs.getString("token");
    }else{
      return prefs.getString("token");
    }
  }

  static Future<int> getIdUser() async{
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs.getInt("id_user");
    }else{
      return prefs.getInt("id_user");
    }
  }

  static login(data) async{
    await prefs.setString('email', data["email"]);
    await prefs.setString('token', data["token"]);
    await prefs.setInt('id_user', data["id_user"]);
  }

  static logout() async{
    await prefs.setString('email', null);
    await prefs.setString('token', null);
    await prefs.setInt('id_user', null);
  }
}