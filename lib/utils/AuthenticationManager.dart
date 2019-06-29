import 'package:mysearch/utils/LocalStorageManager.dart';

class AuthenticationManager{
  static String email = null;
  static int id = null;
  static String token = null;

  static Future<String> getToken() async{
    if (token == null) {
      return LocalStorageManager.getStringValue("token");
    }else{
      return token;
    }
  }

  static Future<int> getIdUser() async{
    if (id == null) {
      return LocalStorageManager.getIntValue("id_user");
    }else{
      return id;
    }
  }

  static login(data) async{
    await LocalStorageManager.storeStringValue('email', data["email"]);
    await LocalStorageManager.storeStringValue('token', data["token"]);
    await LocalStorageManager.storeIntValue('id_user', data["id_user"]);
  }

  static logout() async{
    await LocalStorageManager.storeStringValue('email', null);
    await LocalStorageManager.storeStringValue('token', null);
    await LocalStorageManager.storeIntValue('id_user', null);

    email = null;
    id = null;
    token = null;
  }
}