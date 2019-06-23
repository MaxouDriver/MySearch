import 'package:mysearch/models/filter.dart';
import 'package:mysearch/models/category.dart';

class SearchValue {
  final Category category;
  final List<Filter> filters;
  final List<List<Map<String, double>>> polygons;

  SearchValue({this.category, this.filters, this.polygons});

  factory SearchValue.fromJson(Map<String, dynamic> json) {
    return SearchValue(
      category: Category.fromJson(json["category"]),
      filters: (json['filters'] != null) ? (new List<Map<String, dynamic>>.from(json['filters'])).map((Map<String, dynamic> j) { Filter.fromJson(j, "name");}).toList() : [],
      polygons: (json['polygons'] != null) ? (new List<dynamic>.from(json['polygons'])).toList().cast<List<Map<String, double>>>() : []
    );
  }

  toJson() {
    Map<String, dynamic> search = {
      "category": category.toJson(),
      "filters" :  filters.map((Filter f)=>f.toJson()).toList(),
      "polygons": polygons
    };

    return search;
  }
}