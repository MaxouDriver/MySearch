import 'package:MySearch/models/Auth/login.dart';
import 'package:MySearch/models/server-response.dart';

class LoginResponse extends ServerResponse {
  final Login login;

  LoginResponse(String message, String error, this.login)
      : super(message: message, error: error);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(json["message"], json["error"],
        (json['data'] != null) ? (Login.fromJson(json['data'])) : null);
  }

  factory LoginResponse.withError(String errorValue) {
    return LoginResponse(null, errorValue, null);
  }
}
