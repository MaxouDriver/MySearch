import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mysearch/models/Search/parameter.dart';
import 'package:mysearch/models/Search/search.dart';

class VisualizeSearch extends StatefulWidget {
  final Search search;
  VisualizeSearch({Key key, this.search}) : super(key: key);

  _VisualizeSearchState createState() => _VisualizeSearchState();
}

class _VisualizeSearchState extends State<VisualizeSearch> {
  Search search;
  List<Polygon> polys = [];
  double zoom = 12;
  LatLng center = LatLng(48.858596, 2.339204);

  @override
  initState() {
    super.initState();
    search = widget.search;
    if (search != null) {
      print(search.toJson());
    }

    polys = search.value.polygons.map((List<dynamic> l) {
      List<LatLng> points = [];
      l.forEach((dynamic p){
        points.add(LatLng(p["lat"], p["lng"]));
      });
      return Polygon(points: points);
    }).cast<Polygon>().toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> desc = [];
    desc.add( Text("Query : " + search.value.query.toString()));
    desc.add( Text("Cathegory : " + search.value.category.label.toString()));
    search.value.parameters.forEach((Parameter p)=>{
      desc.add(new Text(p.toString()))
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(search.name),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: ListBody(
                children: desc,
              ),
            )
            ,
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: center,
                    zoom: zoom,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png",
                      subdomains:['mt0','mt1','mt2','mt3']
                  ),
                  PolygonLayerOptions(polygons: polys),
                ],
              ),
            )
          ],
        )
    );
  }
}