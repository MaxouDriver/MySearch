import 'package:mysearch/models/Search/search.dart';
import 'package:mysearch/models/server-response.dart';

class SearchResponse extends ServerResponse {
  final List<Search> searchs;

  SearchResponse(String message, String error, this.searchs) : super(message: message, error: error);

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
        json["message"],
        json["error"],
        (json["searchs"] != null) ? (new List<Map<String, dynamic>>.from(json["searchs"])).map((Map<String, dynamic> j) => Search.fromJson(j)).toList() : []);
  }

  factory SearchResponse.withError(String errorValue) {
    return SearchResponse(null, errorValue, null);
  }
}
