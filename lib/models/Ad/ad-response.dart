import 'package:MySearch/models/Ad/ad.dart';
import 'package:MySearch/models/server-response.dart';

class AdResponse extends ServerResponse {
  final List<Ad> ads;

  AdResponse(String message, String error, this.ads)
      : super(message: message, error: error);

  factory AdResponse.fromJson(Map<String, dynamic> json) {
    return AdResponse(
        json["message"],
        json["error"],
        (json['data'] != null)
            ? (new List<Map<String, dynamic>>.from(json['data']))
                .map((Map<String, dynamic> j) => Ad.fromJson(j))
                .toList()
            : []);
  }

  factory AdResponse.withError(String errorValue) {
    return AdResponse(null, errorValue, null);
  }
}
