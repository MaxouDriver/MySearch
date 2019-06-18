import 'dart:convert';

class Category {
  final String id;
  final String label;
  final String channel;
  final List<Category> subcategories;


  Category({this.id, this.label, this.channel, this.subcategories});

  factory Category.fromJson(Map<String, dynamic> json) {


    return Category(
        id: json['id'],
        label: json['label'],
        channel: json['channel'],
        subcategories: (json['subcategories'] != null) ? (new List<Map<String, dynamic>>.from(json['subcategories'])).map((Map<String, dynamic> j) => Category.fromJson(j)).toList() : []
    );
  }


}