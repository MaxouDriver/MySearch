import 'package:mysearch/models/Search/value.dart';

class Filter {
  final String name;
  final List<Value> values;


  Filter({this.name, this.values});

  factory Filter.fromJson(Map<String, dynamic> json, String name) {
    return Filter(
        name: name,
        values: (json['values'] != null) ? (new List<Map<String, dynamic>>.from(json['values'])).map((Map<String, dynamic> j) => Value.fromJson(j)).toList() : []
    );
  }

  toJson() {
    Map<String, dynamic> res = {
      "name": name,
      "values": values
    };
    return res;
  }
}