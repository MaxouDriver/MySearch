import 'package:mysearch/models/Ad/ad-response.dart';
import 'package:mysearch/models/json-response.dart';
import 'package:mysearch/models/server-response.dart';
import 'package:mysearch/models/Search/search-response.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mysearch/utils/LocalStorageManager.dart';
import 'AuthenticationManager.dart';
import 'package:expire_cache/expire_cache.dart';

class APIManager{
  static final ExpireCache<String, Map<String, dynamic>> cache = ExpireCache<String, Map<String, dynamic>>(expireDuration: new Duration(minutes: 5), sizeLimit: 20);

  static onNotAuthenticated(context){
    Navigator.pushReplacementNamed(context, '/login');
    AuthenticationManager.logout();
  }
  // Method used to retrieve data wherever it's coming from (cache/server)
  static Future<Map<String, dynamic>> retreiveData(String key, String serverUrl, BuildContext context) async{
    Map<String, dynamic> res  = await cache.get(key);
    
    if(res == null) {
      try{
        Response response = await protectedGet(serverUrl, context);
        cache.set(key, response.data);
        res = response.data;
      }catch(e){
        res = {"error": e};
      }
    }

    return res;
  }

  static getEndPoint() async{
    return LocalStorageManager.getStringValue("serverURL") == null ? "" : LocalStorageManager.getStringValue("serverURL");
  }

  static Future<AdResponse> fetchAds(context) async {
    Map<String, dynamic> res = await retreiveData("ads", (await getEndPoint()) + "annonces" + "?id_user=" + (await AuthenticationManager.getIdUser()).toString(), context);
    if(res["error"] != null)
      return AdResponse.withError(res["error"]); 
    else
      return AdResponse.fromJson(res);
  }

  static Future<AdResponse> fetchAdsSince(context) async {
    Map<String, dynamic> res = await retreiveData("adsSince", (await getEndPoint())  + "annonces/since" + "?id_user=" + (await AuthenticationManager.getIdUser()).toString(), context);
    if(res["error"] != null)
      return AdResponse.withError(res["error"]); 
    else
      return AdResponse.fromJson(res);
  }

  static Future<JsonResponse> getTravelTime(lat, lng, context) async {
    try {
      Response response = await protectedGet((await getEndPoint())  + "annonces/travel/" + lng.toString() + ";" + lat.toString(), context);
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<SearchResponse> fetchSearchs(context) async {
    SearchResponse.fromJson(await retreiveData("searchs", (await getEndPoint())  + "search/" + (await AuthenticationManager.getIdUser()).toString(), context));
  }

  static Future<ServerResponse> removeSearch(id_search, context) async {
    try {
      Response response = await protectedPost((await getEndPoint())  + "search/remove", {"id_search": id_search}, context);
      return ServerResponse.fromJson(response.data);
    } catch (e) {
      return ServerResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> login(email, passwd, context) async {
    try {
      Response response = await Dio().post((await getEndPoint())  + "user/login", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> register(email, passwd, context) async {
    try {
      Response response = await Dio().post((await getEndPoint())  + "user/register", data: {"email": email, "passwd": passwd});
      return JsonResponse.fromJson(response.data);
    } catch (e) {
      return JsonResponse.withError(e.toString());
    }
  }

  static Future<JsonResponse> categories(context) async {
     return JsonResponse.fromJson(await retreiveData("categories", (await getEndPoint())  + "categories", context));
  }

  static Future<JsonResponse> filters(id_cat, context) async {
    return JsonResponse.fromJson(await retreiveData("filters", (await getEndPoint())  + "subcategories/" + id_cat.toString(), context));
  }

  static Future<ServerResponse> addSearch(String name, Map<String, dynamic> search, context) async {
    try {
      Response response = await protectedPost((await getEndPoint())  + "search/add", {"id_user": (await AuthenticationManager.getIdUser()) ,"name_search": name , "value_search": search}, context);
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

