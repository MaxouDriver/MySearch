import 'package:mysearch/models/server-response.dart';

class AuthResponse extends ServerResponse {
  final String token;

  AuthResponse(int code, String message, String error, this.token) : super(code: code, message: message, error: error);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(json["code"], json["message"], json["error"], json['token']);
  }

  factory AuthResponse.withError(String errorValue) {
    return AuthResponse(500, null, errorValue, null);
  }
}
