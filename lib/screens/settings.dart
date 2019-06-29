import 'package:flutter/material.dart';
import 'package:mysearch/utils/LocalStorageManager.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController serverURLController = TextEditingController();

  @override
  initState() {
    super.initState();

    init();
  }

  init() async{
    serverURLController.text = await LocalStorageManager.getStringValue("serverURL");
    setState(() { });
  }

  changeText(text) async {
    await LocalStorageManager.storeStringValue("serverURL", text[text.length-1] == "/" ? text : text + "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your search"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: serverURLController,
          decoration: InputDecoration(
              hintText: 'Your server location'
          ),
          onChanged: (text) {
            changeText(text);
          },
        )
      ],
    ),
    );
  }
}