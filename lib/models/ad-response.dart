import 'package:mysearch/models/ad.dart';

class AdResponse {
  final List<Ad> ads;
  final String error;

  AdResponse({this.ads, this.error});

  factory AdResponse.fromJson(Map<String, dynamic> json) {
    return new AdResponse(ads: (json["ads"] as List).map((i) => new Ad.fromJson(i)).toList(), error: "");
  }

  factory AdResponse.withError(String errorValue) {
    return new AdResponse(ads: List(), error: errorValue);
  }
}
