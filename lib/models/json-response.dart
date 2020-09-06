import 'package:MySearch/models/server-response.dart';

class JsonResponse extends ServerResponse {
  final Map<String, dynamic> data;

  JsonResponse(String message, String error, this.data)
      : super(message: message, error: error);

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    JsonResponse response =
        JsonResponse(json["message"], json["error"], json['data']);
    return response;
  }

  factory JsonResponse.withError(String errorValue) {
    return JsonResponse(null, errorValue, null);
  }
}
