import 'package:mysearch/models/Search/search-value.dart';

class Search {
  final int id;
  final String name;
  final bool notificationsEnabled;
  final SearchValue value;

  Search({this.id, this.name, this.notificationsEnabled, this.value});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
        id: json["id_search"],
        name: json["name_search"],
        notificationsEnabled: json["notificationsEnabled_search"],
        value: SearchValue.fromJson(json["value_search"])
    );
  }

  toJson() {
    Map<String, dynamic> search = {
      "id_search": id,
      "name_search": name,
      "notificationsEnabled_search": notificationsEnabled,
      "value_search": value.toJson()
    };

    return search;
  }
}