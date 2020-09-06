import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  //List<Search> searchs = [];
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
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => AddSearch()),
            // );
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
                ))
          ],
        ));
  }
}
