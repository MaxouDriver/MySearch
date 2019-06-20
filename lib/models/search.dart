import 'package:mysearch/models/filter.dart';
import 'package:mysearch/models/category.dart';

class Search {
  final int id;
  final String name;
  final Category category;
  final List<Filter> filters;
  final List<List<Map<String, double>>> polygons;


  Search({this.id, this.name, this.category, this.filters, this.polygons});

  factory Search.fromJson(Map<String, dynamic> json, String name) {
    print(json);
    return Search(
      id: json["id_search"],
      name: json["name_search"],
      category: Category.fromJson(json["value_search"]["category"]),
      filters: (json["value_search"]['filters'] != null) ? (new List<Map<String, dynamic>>.from(json["value_search"]['filters'])).map((Map<String, dynamic> j) => Filter.fromJson(j, "name")).toList() : [],
      polygons: (json["value_search"]['polygons'] != null) ? (new List<Map<String, double>>.from(json["value_search"]['location'])).toList() : []
    );
  }

  toJson() {
    Map<String, dynamic> search = {
      "id_search": id,
      "name": name,
      "category": category.toJson(),
      "filters" :  filters,
      "location": polygons
    };

    return search;
  }
}