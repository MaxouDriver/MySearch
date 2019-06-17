import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'package:mysearch/screens/search.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/models/ad-response.dart';

final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  GlobalKey _keyRed = GlobalKey();
  bool _position = true;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        position: InnerDrawerPosition.start, // required
        onTapClose: true, // default false
        swipe: true, // default true
        offset: 0.6, // default 0.4
        colorTransition: Color(0xFF1A1A28), // default Color.black54
        animationType: InnerDrawerAnimation.linear, // default static
        innerDrawerCallback: (a) => print(a), // return bool
        child: Material(
            child: SafeArea(
              child: Stack(
                key: _keyRed,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top:12,bottom: 4, left: 15),
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
                                  onTap: ()
                                  {
                                    _innerDrawerKey.currentState.close();
                                  },
                                ),
                              ),
                            ],
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
        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
        scaffold: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false
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
            )
        )
    );
  }
}