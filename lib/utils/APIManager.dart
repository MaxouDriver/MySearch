import 'package:mysearch/models/ad-response.dart';
import 'package:mysearch/models/auth-response.dart';
import 'package:mysearch/models/json-response.dart';
import 'package:dio/dio.dart';
import 'dart:async';


class APIManager{
  static final String endpoint = "http://192.168.1.19:3000/base/";

  static Future<AdResponse> fetchAds() async {
    try {
      Response response = await Dio().get("http://192.168.1.19:3000/base/");
      return AdResponse.fromJson(response.data);
    } catch (e) {
      return AdResponse.withError(e);
    }
  }

  static Future<AuthResponse> login(email, passwd) async {
    try {
      Response response = await Dio().post("http://192.168.1.19:3000/base/user/login", data: {"email": email, "passwd": passwd});
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return AuthResponse.withError(e);
    }
  }

  static Future<AuthResponse> register(email, passwd) async {
    try {
      Response response = await Dio().post("http://192.168.1.19:3000/base/user/register", data: {"email": email, "passwd": passwd});
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return AuthResponse.withError(e);
    }
  }

  static Future<JsonResponse> categories() async {
    try {
      Response response = await Dio().get("http://192.168.1.19:3000/base/categories");
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e);
    }
  }
}

