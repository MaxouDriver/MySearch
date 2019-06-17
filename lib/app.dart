import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysearch/screens/login.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySearch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1A1A28),
      ),
      home: Login(),
    );
  }
}