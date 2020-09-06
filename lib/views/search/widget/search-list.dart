import 'package:MySearch/models/Ad/ad.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

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
                      //_showDialog(ad, context);
                    })))
            .toList());
  }
}

// FutureBuilder<SearchResponse>(
//                 future: APIManager.fetchSearchs(context),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     if (snapshot.data.searchs == null) return Text("No data");

//                     return new ListView(
//                         children: snapshot.data.searchs
//                             .map((search) => Card(
//                                 margin: const EdgeInsets.all(10),
//                                 child: ListTile(
//                                   title: new Text(search.name),
//                                   trailing: IconButton(
//                                       icon: Icon(Icons.delete),
//                                       onPressed: () {
//                                         APIManager.removeSearch(
//                                             search.id, context);
//                                       }),
//                                   onTap: () {
//                                     var route = new MaterialPageRoute(
//                                       builder: (BuildContext context) =>
//                                           new VisualizeSearch(search: search),
//                                     );
//                                     Navigator.of(context).push(route);
//                                   },
//                                 )))
//                             .toList());
//                   } else if (snapshot.hasError) {
//                     return Text("${snapshot.error}");
//                   }
//                   return CircularProgressIndicator();
//                 },
// )
