import 'package:mysearch/models/Search/value.dart';

class Parameter {
  final String name;
  final List<Value> values;


  Parameter({this.name, this.values});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
        name: json["name"],
        values: (json['values'] != null) ? (new List<Map<String, dynamic>>.from(json['values'])).map((Map<String, dynamic> j) => Value.fromJson(j)).toList() : []
    );
  }

  toJson() {
    Map<String, dynamic> res = {
      "name": name,
      "values": values.map((Value v)=>v.toJson()).toList()
    };
    return res;
  }

  @override
  toString(){
    return name + values.toString();
  }
}