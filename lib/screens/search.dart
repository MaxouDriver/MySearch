import 'package:flutter/material.dart';
import 'package:mysearch/screens/add_search.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                ListTile(
                    leading: new CircleAvatar(child: new Text("hey")),
                    title: new Text("hey"),
                    subtitle: new Text("hey")
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}