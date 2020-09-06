import 'dart:convert';
import 'dart:io';

import 'package:MySearch/utils/AuthenticationManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestManager {
  static final String API_END_POINT_URL = "http://192.168.0.13:3000/";

  static Future<Map<String, dynamic>> get(
      BuildContext context, String url) async {
    print("before");
    print("bearer " + (await AuthenticationManager.getToken().toString()));
    print("after");
    try {
      var response = await http.get(
        API_END_POINT_URL + url,
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader:
              "bearer " + (await AuthenticationManager.getToken())
        },
      );
      if (response.statusCode == 401)
        AuthenticationManager.onNotAuthenticated(context);
      return await json.decode(response.body);
    } catch (exception) {
      return {'message': 'Error', 'error': exception.toString()};
    }
  }

  static Future<Map<String, dynamic>> post(
      BuildContext context, String url, body) async {
    try {
      var response = await http.post(
        API_END_POINT_URL + url,
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "bearer " + (await AuthenticationManager.getToken())
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 401)
        AuthenticationManager.onNotAuthenticated(context);
      return await json.decode(response.body);
    } catch (exception) {
      return {'message': 'Error', 'error': exception.toString()};
    }
  }
}
