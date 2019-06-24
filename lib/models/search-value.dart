
import 'package:mysearch/models/category.dart';
import 'package:mysearch/models/parameter.dart';

class SearchValue {
  final String query;
  final Category category;
  final List<Parameter> parameters;
  final List<List<Map<String, double>>> polygons;

  SearchValue({this.query, this.category, this.parameters, this.polygons});

  factory SearchValue.fromJson(Map<String, dynamic> json) {
    return SearchValue(
      query: json["query"],
      category: Category.fromJson(json["category"]),
      parameters: (json['parameters'] != null) ? (new List<Map<String, dynamic>>.from(json['parameters'])).map((Map<String, dynamic> j) { Parameter.fromJson(j);}).toList() : [],
      polygons: (json['polygons'] != null) ? (new List<dynamic>.from(json['polygons'])).toList().cast<List<Map<String, double>>>() : []
    );
  }

  toJson() {
    Map<String, dynamic> search = {
      "name": query,
      "category": category.toJson(),
      "parameters" :  parameters.map((Parameter p)=>p.toJson()).toList(),
      "polygons": polygons
    };

    return search;
  }
}