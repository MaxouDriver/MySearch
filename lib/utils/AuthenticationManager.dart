import 'package:MySearch/models/Auth/login.dart';
import 'package:MySearch/utils/LocalStorageManager.dart';
import 'package:flutter/material.dart';

class AuthenticationManager {
  static String email = null;
  static int id = null;
  static String token = null;

  static Future<String> getToken() async {
    if (token == null) {
      return LocalStorageManager.getStringValue("token");
    } else {
      return token;
    }
  }

  static Future<int> getIdUser() async {
    if (id == null) {
      return LocalStorageManager.getIntValue("id_user");
    } else {
      return id;
    }
  }

  static login(Login loginInfos) async {
    await LocalStorageManager.storeStringValue('email', loginInfos.email);
    await LocalStorageManager.storeStringValue('token', loginInfos.token);
    await LocalStorageManager.storeIntValue('id_user', loginInfos.idUser);
  }

  static logout() async {
    await LocalStorageManager.storeStringValue('email', null);
    await LocalStorageManager.storeStringValue('token', null);
    await LocalStorageManager.storeIntValue('id_user', null);

    email = null;
    id = null;
    token = null;
  }

  static onNotAuthenticated(context) {
    Navigator.pushReplacementNamed(context, '/login');
    logout();
  }
}
