import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager{
  static Map<String, dynamic> infos;

  static  login(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', data["email"]);
    await prefs.setString('token', data["token"]);
    await prefs.setInt('id_user', data["id_user"]);
  }

  static Future<Map<String, dynamic>> getInfos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      "email" : prefs.getString('email'),
      "id_user": prefs.getInt('id_user'),
      "token": prefs.getString('token')
    };
  }

  static logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', null);
    await prefs.setString('token', null);
    await prefs.setInt('id_user', null);
  }
}