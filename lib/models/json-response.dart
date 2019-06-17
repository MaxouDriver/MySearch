import 'package:mysearch/models/server-response.dart';

class JsonResponse extends ServerResponse {
  final Map<String, dynamic> json;

  JsonResponse(int code, String message, String error, this.json) : super(code: code, message: message, error: error);

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(json["code"], json["message"], json["error"], json['json']);
  }

  factory JsonResponse.withError(String errorValue) {
    return JsonResponse(500, null, errorValue, null);
  }
}
