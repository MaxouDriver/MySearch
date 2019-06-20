import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mysearch/models/category.dart';
import 'package:mysearch/models/filter.dart';
import 'package:mysearch/models/search.dart';
import 'package:mysearch/models/value.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/models/json-response.dart';

class AddSearch extends StatefulWidget {
  AddSearch({Key key}) : super(key: key);

  _AddSearchState createState() => _AddSearchState();
}

class _AddSearchState extends State<AddSearch> {
  List<Filter> filtersList = [];
  List<LatLng> tappedPoints = [];
  List<Polygon> polys = [];
  List<DropdownMenuItem<Category>> items = [];
  List<DropdownButton<Value>> drops = [];
  double zoom = 12;
  LatLng center = LatLng(48.858596, 2.339204);

  final _formKey = GlobalKey<FormState>();
  Category _category = null;
  Map<String, Value> filters = {};
  final _queryController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  initState() {
    super.initState();

    getItems().then((value)=> setState(()=> items = value));
  }


  Future<List<Filter>> getFilters(id) async{
    JsonResponse res = await APIManager.filters(id, context);

    List<Filter> filts = [];

    print(res.json);
    
    res.json["subcategories"].forEach((String s, dynamic value){
      Filter f = Filter.fromJson(value, s);
      if (f.values.length > 0) {
        try {
          int.parse(f.values[0].label);

          filts.add(Filter.fromJson(value, s + ' min'));
          filts.add(Filter.fromJson(value, s + ' max'));
        } catch (e) {
          filts.add(Filter.fromJson(value, s));
        }
      }
    });

    return filts;
  }

  DropdownButton<Value> generateDropdown(Filter f){
    return new DropdownButton<Value>(
      value: filters[f.name],
      hint: Text(f.name.toString()),
      onChanged: (Value newValue) {
        setState(() {
          filters[f.name] = newValue;
        });
      },
      items: f.values.map<DropdownMenuItem<Value>>((Value value) {
        return new DropdownMenuItem<Value>(
          value: value,
          child: Text(value.label.toString()),
        );
      }).toList(),
    );
  }

  Column getDrops(){
    List<Widget> vals = [];
    int i = 0;


    while(i < filtersList.length){
      Filter f = filtersList[i];

      if (i + 1  < filtersList.length &&
          f.name.split(" ")[0] == filtersList[i + 1].name.split(" ")[0]) {
        vals.add(Row(children: <Widget>[generateDropdown(f), generateDropdown(filtersList[i + 1])],));
        i+=2;
      }else{
        vals.add(generateDropdown(f));
        i+=1;
      }
    }


    return Column(children: vals);
  }

  Future<List<DropdownMenuItem<Category>>> getItems() async{
    JsonResponse res = await APIManager.categories(context);
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



  sendSearch(){
    List<Filter> listeOfFilters = [];

    filters.forEach((String s, Value v) => listeOfFilters.add(Filter.fromJson(v.toJson(), s)));

    Search search = Search(
      category: _category,
      filters : listeOfFilters,
      polygons: polys.map((Polygon p) => p.points.map((LatLng l) => {"lat": l.latitude, "lng": l.longitude}).toList()).toList()
    );

    APIManager.addSearch(_nameController.text, search.toJson(), context).then((value)=>print(value));
  }


  @override
  Widget build(BuildContext context) {

    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 35,
        height: 35,
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
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: Text("Ajouter"),
          onPressed: (){
            sendSearch();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'name',
                          labelText: 'Name your search',
                        )
                    ),
                    TextFormField(
                        controller: _queryController,
                        decoration: const InputDecoration(
                          hintText: 'nice car',
                          labelText: 'What are you searching for',
                        )
                    ),
                    DropdownButton<Category>(
                      value: _category,
                      hint: Text("Category"),
                      onChanged: (Category newValue) {
                        setState(() {
                          _category = newValue;
                          getFilters(_category.id).then((value)=> setState(()=> filtersList = value));
                        });
                      },
                      items: items,
                    )
                    , getDrops()
                  ]
              )// Build this out in the next steps.
            )
            ,
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: center,
                    zoom: zoom,
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
            )
          ],
        )
    );
  }
}