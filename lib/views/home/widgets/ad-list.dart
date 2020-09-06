import 'package:MySearch/models/Ad/ad.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

Widget adListWidget(List<Ad> ads, String message, BuildContext context) {
  return Stack(
    children: [
      Container(
        color: Theme.of(context).primaryColor,
        height: 55.0,
      ),
      Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: adList(ads, message, context)),
    ],
  );
}

Widget adList(List<Ad> ads, String message, BuildContext context) {
  if (ads == null)
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "${message}",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  else {
    if (ads.length == 0) return Text("No data");
    return new ListView(
        children: ads
            .map((ad) => Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                    leading: Image.network(ad.images.thumbUrl,
                        width: 110, fit: BoxFit.fitWidth),
                    title: new Text(ad.subject),
                    onTap: () {
                      _showDialog(ad, context);
                    })))
            .toList());
  }
}

void _showDialog(Ad ad, BuildContext context) {
  double zoom = 12;
  LatLng center = LatLng(48.858596, 2.339204);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(ad.subject),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              CarouselSlider(
                items: ad.images.urls.map((link) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Image.network(link, fit: BoxFit.fitWidth));
                    },
                  );
                }).toList(),
              ),
              new RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: "date", //ad.date.toString(),
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: ad.price.toString() + "€",
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: ad.body,
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: 'Lien vers l\'annonce',
                      style: new TextStyle(color: Colors.blue),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          //launch(ad.link);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
