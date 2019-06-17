import 'package:mysearch/models/ad-location.dart';

class Ad {
  final int adId;
  final String title;
  final String description;
  final String category;
  final String link;
  final List<String> images;
  final AdLocation location;


  Ad({this.adId, this.title, this.description, this.category, this.link, this.images, this.location});

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      adId: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      link: json['link'],
      images: new List<String>.from(json["images"]),
      location: AdLocation.fromJson(json["location"])
    );
  }
}
