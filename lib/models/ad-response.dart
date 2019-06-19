import 'package:mysearch/models/ad.dart';
import 'package:mysearch/models/server-response.dart';

class AdResponse extends ServerResponse {
  final List<Ad> ads;

  AdResponse(String message, String error, this.ads) : super(message: message, error: error);

  factory AdResponse.fromJson(Map<String, dynamic> json) {
    return AdResponse(json["message"], json["error"], (json['ads'] != null) ? (new List<Map<String, dynamic>>.from(json['ads'])).map((Map<String, dynamic> j) => Ad.fromJson(j)).toList() : []);
  }

  factory AdResponse.withError(String errorValue) {
    return AdResponse(null, errorValue, null);
  }
}
