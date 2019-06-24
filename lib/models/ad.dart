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
      images: (json["images"] != null) ? new List<String>.from(json["images"]) : ["https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png"],
      location: AdLocation.fromJson(json["location"])
    );
  }
}
