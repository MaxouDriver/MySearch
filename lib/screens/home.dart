import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mysearch/screens/search.dart';
import 'package:mysearch/screens/settings.dart';
import 'package:mysearch/screens/login.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/utils/AuthenticationManager.dart';
import 'package:mysearch/models/ad-response.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  GlobalKey _keyRed = GlobalKey();
  bool _position = true;



  @override
  Widget build(BuildContext context) {
    AuthenticationManager.getInfos().then((value){
      if(value["token"] == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }).catchError((error){
      print(error.toString());
    });

    return Scaffold(
      appBar: AppBar(title: Text("MySearch")),
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
            child: FutureBuilder<AdResponse>(
              future: APIManager.fetchAds(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                            MaterialPageRoute(builder: (_) => Search()),
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