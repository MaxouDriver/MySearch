
import 'package:mysearch/models/Search/category.dart';
import 'package:mysearch/models/Search/parameter.dart';

class SearchValue {
  final String query;
  final Category category;
  final List<Parameter> parameters;
  final List<List<dynamic>> polygons;

  SearchValue({this.query, this.category, this.parameters, this.polygons});

  factory SearchValue.fromJson(Map<String, dynamic> json) {
    List<Parameter> pa = [];
    new List<Map<String, dynamic>>.from(json['parameters']).forEach((Map<String, dynamic> j) { pa.add(Parameter.fromJson(j));});

    return SearchValue(
      query: json["query"],
      category: (json['category'] != null) ? Category.fromJson(json["category"]) :null,
      parameters: pa,
      polygons: new List<List<dynamic>>.from(json['polygons'])
    );
  }

  toJson() {
    Map<String, dynamic> search = {
      "query": query,
      "category": category.toJson(),
      "parameters" :  (parameters != null && parameters.length > 0) ? parameters.map((Parameter p)=>p.toJson()).toList() : [],
      "polygons": polygons
    };

    return search;
  }
}