import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysearch/models/Ad/ad.dart';
import 'package:mysearch/models/json-response.dart';

import 'package:mysearch/screens/search-list.dart';
import 'package:mysearch/screens/settings.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/utils/AuthenticationManager.dart';
import 'package:mysearch/models/Ad/ad-response.dart';

import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  GlobalKey _keyRed = GlobalKey();
  bool _position = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> executeAfterBuild() async {
    if (AuthenticationManager.getToken() == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _showDialog(Ad ad) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(ad.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CarouselSlider(
                  items: ad.images.map((link) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber
                            ),
                            child:  Image.network(link, fit: BoxFit.fitWidth)
                        );
                      },
                    );
                  }).toList(),
                ),
                Text(ad.date.toString()),
                Text(ad.price.toString() + "€"),
                Text(ad.description),
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


  @override
  Widget build(BuildContext context) {
    executeAfterBuild();
    return Scaffold(
      appBar: AppBar(title: Text("MySearch")),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Text("All")),
                Tab(icon: Text("Newest")),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Stack(
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
                    child: FutureBuilder<AdResponse>(
                      future: APIManager.fetchAds(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.error != null){
                            return Text("${snapshot.error}");
                          } print(snapshot.data.error);
                          if (snapshot.data.ads == null) return Text("No data");

                          return new ListView(
                              children: snapshot.data.ads.map((ad) => Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                      leading: Image.network(ad.images[0], width: 110,fit: BoxFit.fitWidth),
                                      title: new Text(ad.title),
                                      onTap: () { _showDialog(ad); }
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
              Stack(
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
                    child: FutureBuilder<AdResponse>(
                      future: APIManager.fetchAdsSince(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.error != null){
                            return Text("${snapshot.error}");
                          } print(snapshot.data.error);
                          if (snapshot.data.ads == null) return Text("No data");

                          return new ListView(
                              children: snapshot.data.ads.map((ad) => Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                      leading: Image.network(ad.images[0], width: 110,fit: BoxFit.fitWidth),
                                      title: new Text(ad.title)
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
              )

            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Material(
            child: SafeArea(
              child: Stack(
                key: _keyRed,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top:12,bottom: 4, left: 15),
                          child: GestureDetector(
                            onTap: () { print("Container was tapped"); },
                            child: PopupMenuButton<String>(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircleAvatar(
                                          child: Icon(Icons.person,color: Colors.white,size: 12),
                                          backgroundColor: Colors.grey,
                                        ),
                                      ),
                                      Text("   Guest",
                                        style: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:2, right: 25),
                                    child: GestureDetector(
                                      child: Icon(
                                        _position ? Icons.arrow_back:Icons.arrow_forward,
                                        size: 18,),
                                    ),
                                  ),
                                ],
                              ),
                              onSelected: (String s) {
                                if (s == "Lougout") {
                                  AuthenticationManager.logout();
                                  Navigator.pushReplacementNamed(context, '/login');
                                }
                              },
                              itemBuilder: (BuildContext context){
                                return <String>["Lougout"].map((String choice){
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                          )
                      ),
                      Divider(),
                      ListTile(
                        title:  Text("Saved search"),
                        leading:Icon(Icons.search),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SearchList()),
                          );
                        },
                      ),
                      ListTile(
                        title:  Text("Settings"),
                        leading:Icon(Icons.settings),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => Settings()),
                          );
                        },
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                        width: 20,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                            border: Border(top: BorderSide(color: Colors.grey[200],))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.settings,size: 18,),
                            Text("  Settings",
                              style: TextStyle( fontSize: 16),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}