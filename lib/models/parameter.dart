import 'package:mysearch/models/value.dart';

class Parameter {
  final String name;
  final Value value;


  Parameter({this.name, this.value});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
        name: json["name"],
        value: (json['value'] != null) ? Value.fromJson(json["value"]): null
    );
  }

  toJson() {
    Map<String, dynamic> res = {
      "name": name,
      "value": value.toJson()
    };
    return res;
  }
}