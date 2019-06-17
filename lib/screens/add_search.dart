import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mysearch/utils/APIManager.dart';

class AddSearch extends StatefulWidget {
  AddSearch({Key key}) : super(key: key);

  _AddSearchState createState() => _AddSearchState();
}

class _AddSearchState extends State<AddSearch> {
  List<LatLng> tappedPoints = [];
  List<Polygon> polys = [];
  List<String> items = ["a"];

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  final _queryController = TextEditingController();



  @override
  initState() {
    super.initState();

    APIManager.categories().then((value) =>
        setState(() {
          value.json.forEach((String s, dynamic value){
            items.add(value["label"]);
          });
        })
    );
  }


  @override
  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(
          child: GestureDetector(
            onTap: () {
              if (latlng == tappedPoints[0]) {
                setState(() {
                  polys.add(new Polygon(points: tappedPoints));
                  tappedPoints = [];
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          )
        ),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _queryController,
              decoration: const InputDecoration(
                hintText: 'nice car',
                labelText: 'What are you searching for',
              )
            ),DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: items.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
              )
            ,
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(45.5231, -122.6765),
                    zoom: 13.0,
                    onTap: (latlng) {
                      setState(() {
                      tappedPoints.add(latlng);
                    });
                }),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png",
                      subdomains:['mt0','mt1','mt2','mt3']
                  ),
                  PolygonLayerOptions(polygons: polys),
                  MarkerLayerOptions(markers: markers),

                ],
              ),
            ),
            RaisedButton(
              child: new Text("SignUp"),
              color:  Colors.blueAccent[600],
              onPressed: (){

              },
            )
          ],
        )
    );
  }

  void _onClick(){

  }
}