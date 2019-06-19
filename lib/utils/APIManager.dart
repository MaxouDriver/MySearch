import 'package:mysearch/models/ad-response.dart';
import 'package:mysearch/models/json-response.dart';
import 'package:mysearch/models/server-response.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'AuthenticationManager.dart';
import 'dart:io';

class APIManager{
  static final String endpoint = "http://192.168.1.18:3000/base/";

  static onNotAuthenticated(context){
    Navigator.pushReplacementNamed(context, '/login');
    AuthenticationManager.logout();
  }

  static Future<AdResponse> fetchAds(context) async {
    try {
      Response response = await Dio().get(endpoint, options: Options(
        headers: {
          "Authorization": (await AuthenticationManager.getInfos())["token"],
        },
      ));

      if (response.statusCode == 403) onNotAuthenticated(context);

      return AdResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return AdResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> login(email, passwd, context) async {
    try {
      Response response = await Dio().post(endpoint + "user/login", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> register(email, passwd, context) async {
    try {
      Response response = await Dio().post(endpoint + "user/register", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> categories(context) async {
    try {
      Response response = await Dio().get(endpoint + "categories", options: Options(
        headers: {
          HttpHeaders.authorizationHeader: (await AuthenticationManager.getInfos())["token"],
        },
      ));

      if (response.statusCode == 403) onNotAuthenticated(context);

      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> filters(id_cat, context) async {
    try {
      Response response = await Dio().get(endpoint + "subcategories/" + id_cat.toString(), options: Options(
        headers: {
          HttpHeaders.authorizationHeader: (await AuthenticationManager.getInfos())["token"],
        },
      ));

      if (response.statusCode == 403) onNotAuthenticated(context);

      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<ServerResponse> addSearch(String name, Map<String, dynamic> search, context) async {
    try {
      Response response = await Dio().post(endpoint + "search/add", data: {"id_user": (await AuthenticationManager.getInfos())["id_user"] ,"name_search": name , "value_search": search}, options: Options(
        headers: {
          HttpHeaders.authorizationHeader: (await AuthenticationManager.getInfos())["token"],
        },
      ));

      if (response.statusCode == 403) onNotAuthenticated(context);

      return ServerResponse.fromJson(response.data);
    } catch (e) {
      return ServerResponse.withError(e.toString());
    }
  }
}

