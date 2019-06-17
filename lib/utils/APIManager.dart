import 'package:mysearch/models/ad-response.dart';
import 'package:mysearch/models/json-response.dart';
import 'package:dio/dio.dart';
import 'dart:async';


class APIManager{
  static final String endpoint = "http://192.168.1.17:3000/base/";

  static Future<AdResponse> fetchAds() async {
    try {
      Response response = await Dio().get(endpoint);
      return AdResponse.fromJson(response.data);
    } catch (e) {
      return AdResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> login(email, passwd) async {
    try {
      Response response = await Dio().post(endpoint + "user/login", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> register(email, passwd) async {
    try {
      Response response = await Dio().post(endpoint + "user/register", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> categories() async {
    try {
      Response response = await Dio().get(endpoint + "categories");
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }
}

