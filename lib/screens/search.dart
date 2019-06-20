import 'package:flutter/material.dart';
import 'package:mysearch/screens/add_search.dart';
import 'package:mysearch/models/search-response.dart';
import 'package:mysearch/utils/APIManager.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Search> searchs = [];
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your search"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text("Ajouter"),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddSearch()),
          );
        },
      ),
      body: Stack(
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
            child: FutureBuilder<SearchResponse>(
              future: APIManager.fetchSearchs(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  if (snapshot.data.searchs == null) return Text("No data");

                  return new ListView(
                      children: snapshot.data.searchs.map((search) => Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: new Text(search.name),
                              trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                                APIManager.removeSearch(search.id, context);
                              }),
                          )
                      )
                      ).toList());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}