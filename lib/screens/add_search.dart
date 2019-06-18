import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mysearch/models/category.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/models/json-response.dart';

class AddSearch extends StatefulWidget {
  AddSearch({Key key}) : super(key: key);

  _AddSearchState createState() => _AddSearchState();
}

class _AddSearchState extends State<AddSearch> {
  List<LatLng> tappedPoints = [];
  List<Polygon> polys = [];
  List<DropdownMenuItem<Category>> items = [];

  final _formKey = GlobalKey<FormState>();
  Category dropdownValue = null;
  final _queryController = TextEditingController();

  @override
  initState() {
    super.initState();

    getItems().then((value)=> setState(()=> items = value));
  }

  Future<List<DropdownMenuItem<Category>>> getItems() async{
    JsonResponse res = await APIManager.categories();
    List<Category> cats = res.json["categories"].map((dynamic value) => Category.fromJson(value)).toList().cast<Category>();
    List<Category> catsReduce = [];
    cats.forEach((c){
      if (c.subcategories == null) {
        catsReduce.add(c);
      }else{
        catsReduce.add(c);

        catsReduce.addAll(c.subcategories);
      }
    });
    return catsReduce.map<DropdownMenuItem<Category>>((Category value) {
          return new DropdownMenuItem<Category>(
            value: value,
            child: Text(value.label.toString()),
          );
        }).toList();
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
            ),DropdownButton<Category>(
                value: dropdownValue,
                onChanged: (Category newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: items,
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