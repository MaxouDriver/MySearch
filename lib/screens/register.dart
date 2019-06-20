import 'package:flutter/material.dart';
import 'package:mysearch/utils/APIManager.dart';
import 'package:mysearch/utils/AuthenticationManager.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

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
                return 'We need your password';
              }
              return null;
            },
            ),
            TextFormField(
              controller: _passwordConfirmationController, obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: '******',
                labelText: 'Password confirmation *',
              ),validator: (value) {
              if (value.isEmpty) {
                return 'We need your confirmation password';
              }else if (value != _passwordController.text){
                return "Passwords don\'t match";
              }else {
                return null;
              }
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
                        _performRegistration(context);
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      )
    );
  }

  void _performRegistration(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    APIManager.register(email, password, context).then((value) =>
    value.json["token"] != null ? _onRegisterSuccess(context, value.json) : _onRegisterFailure(context, value.error)
    ).catchError((error) => _onRegisterFailure(context, error));
  }

  void _onRegisterSuccess(BuildContext context, infos){
    AuthenticationManager.login(infos);
    Navigator.pushReplacementNamed(context, '/');
  }

  void _onRegisterFailure(BuildContext context, message){
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }
}