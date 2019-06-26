import 'package:mysearch/models/ad-location.dart';
import 'package:mysearch/models/ad-owner.dart';

class Ad {
  final int adId;
  final String title;
  final String description;
  final String category;
  final String link;
  final List<String> images;
  final AdLocation location;
  final bool urgent;
  final int price;
  final DateTime date;
  final AdOwner owner;
  final Map<String, dynamic> attributes;


  Ad({this.adId, this.title, this.description, this.category,
    this.link, this.images, this.location, this.urgent, this.price, this.date, this.owner, this.attributes});

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      adId: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      link: json['link'],
      images: (json["images"] != null) ? new List<String>.from(json["images"]) : ["https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png"],
      location: AdLocation.fromJson(json["location"]),
      urgent: json['urgent'],
      price: json['price'],
      date: DateTime.parse(json['date']),
      owner: AdOwner.fromJson(json['owner']),
      attributes: json['attributes']
    );
  }
}
