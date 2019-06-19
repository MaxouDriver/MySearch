import 'package:flutter/material.dart';
import 'package:mysearch/screens/register.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/utils/AuthenticationManager.dart';

import 'package:mysearch/screens/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Builder(
      builder: (context) => Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'example@gmail.com',
                  labelText: 'Email *',
                ),validator: (value) {
                  if (value.isEmpty) {
                    return 'We need your email';
                  }
                  return null;
                },
              ),TextFormField(
                controller: _passwordController, obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: '******',
                  labelText: 'Password *',
                ),validator: (value) {
                  if (value.isEmpty) {
                    return 'We need your email';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new Row(

                children: <Widget>[

                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                        _performLogin(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                  RaisedButton(
                    child: new Text("SignUp"),
                    color:  Colors.blueAccent[600],
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Register()),
                      );
                    },
                  ),
                ],
                ),
              )
            ],
          ),
        ),
      ),
      )
    );
  }

  void _performLogin(BuildContext context) {
    String username = _emailController.text;
    String password = _passwordController.text;

    APIManager.login(username, password, context).then((value) =>
      value.error == null ? _onLoginSuccess(context, value.json) : _onLoginFailure(context, value.error)
    ).catchError((error) => _onLoginFailure(context, error.toString()));
  }

  void _onLoginSuccess(BuildContext context, infos){
    AuthenticationManager.login(infos);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  void _onLoginFailure(BuildContext context, message){
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }
}