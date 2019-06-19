import 'package:mysearch/models/server-response.dart';

class JsonResponse extends ServerResponse {
  final Map<String, dynamic> json;

  JsonResponse(String message, String error, this.json) : super(message: message, error: error);

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(json["message"], json["error"], json['json']);
  }

  factory JsonResponse.withError(String errorValue) {
    return JsonResponse(null, errorValue, null);
  }
}
