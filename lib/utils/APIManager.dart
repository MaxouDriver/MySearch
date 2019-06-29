import 'package:latlong/latlong.dart';
import 'package:mysearch/models/Ad/ad-response.dart';
import 'package:mysearch/models/json-response.dart';
import 'package:mysearch/models/server-response.dart';
import 'package:mysearch/models/Search/search-response.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'AuthenticationManager.dart';

class APIManager{
  static final String endpoint = "http://192.168.1.19:3000/base/";

  static onNotAuthenticated(context){
    Navigator.pushReplacementNamed(context, '/login');
    AuthenticationManager.logout();
  }

  static Future<AdResponse> fetchAds(context) async {
    try {
      Response response = await protectedGet(endpoint + "annonces" + "?id_user=" + (await AuthenticationManager.getIdUser()).toString(), context);
      return AdResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return AdResponse.withError(e.toString());
    }
  }

  static Future<AdResponse> fetchAdsSince(context) async {
    try {
      Response response = await protectedGet(endpoint + "annonces/since" + "?id_user=" + (await AuthenticationManager.getIdUser()).toString(), context);
      print(response.data);
      return AdResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return AdResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> getTravelTime(lat, lng, context) async {
    try {
      Response response = await protectedGet(endpoint + "annonces/travel/" + lng.toString() + ";" + lat.toString(), context);
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<SearchResponse> fetchSearchs(context) async {
    try {
      Response response = await protectedGet(endpoint + "search/" + (await AuthenticationManager.getIdUser()).toString(), context);
      return SearchResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return SearchResponse.withError(e.toString());
    }
  }

  static Future<ServerResponse> removeSearch(id_search, context) async {
    try {
      Response response = await protectedPost(endpoint + "search/remove", {"id_search": id_search}, context);
      return ServerResponse.fromJson(response.data);
    } catch (e) {
      return ServerResponse.withError(e.toString());
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
      Response response = await protectedGet(endpoint + "categories", context);
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> filters(id_cat, context) async {
    try {
      Response response = await protectedGet(endpoint + "subcategories/" + id_cat.toString(), context);
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<ServerResponse> addSearch(String name, Map<String, dynamic> search, context) async {
    try {
      Response response = await protectedPost(endpoint + "search/add", {"id_user": (await AuthenticationManager.getIdUser()) ,"name_search": name , "value_search": search}, context);
      return ServerResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return ServerResponse.withError(e.toString());
    }
  }

  static Future<Response> protectedPost(url, params, context) async {
      return await Dio().post(url, data: params,options: Options(
          headers: {
            "Authorization": (await AuthenticationManager.getToken()),
          },
          validateStatus: (status) {
            if (status == 403) {
              onNotAuthenticated(context);
              return false;
            } else return true;
          }
      ));
  }

  static Future<Response> protectedGet(url, context) async {
    return await Dio().get(url, options: Options(
        headers: {
          "Authorization": (await AuthenticationManager.getToken()),
        },
        validateStatus: (status) {
          if (status == 403) {
            onNotAuthenticated(context);
            return false;
          } else return true;
        }
    ));
  }
}

