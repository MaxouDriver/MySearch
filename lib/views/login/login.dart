import 'package:MySearch/models/Auth/login-response.dart';
import 'package:MySearch/views/login/login-view-model.dart';
import 'package:flutter/material.dart';
import 'package:MySearch/utils/AuthenticationManager.dart';
import 'package:stacked/stacked.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        disposeViewModel: false,
        builder: (context, viewModel, child) {
          return Container(
              color: Colors.white,
              child: SafeArea(
                  child: Scaffold(
                appBar: buildAppBar(),
                body: buildBody(viewModel, context),
              )));
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("MySearch"),
    );
  }

  Widget buildBody(viewModel, context) {
    final _formKey = GlobalKey<FormState>();

    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    void _onLoginSuccess(BuildContext context, infos) {
      print("_onLoginSuccess login.dart - line 36 : " + infos.toString());
      AuthenticationManager.login(infos).then((void e) {
        Navigator.pushReplacementNamed(context, '/');
      });
    }

    void _onLoginFailure(BuildContext context, message) {
      print("_onLoginSuccess login.dart - line 43 : " + message);
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(message),
      ));
    }

    void _performLogin(BuildContext context) {
      String username = _emailController.text;
      String password = _passwordController.text;

      viewModel
          .login(username, password, context)
          .then((value) => value is LoginResponse
              ? _onLoginSuccess(context, value.login)
              : _onLoginFailure(context, value.error))
          .catchError((error) => _onLoginFailure(context, error.toString()));
    }

    /// building our UI
    /// notice we are observing viewModel.apiResponseModel
    /// Hence buildDataWidget will rebuild when apiResponse changes in ViewModel
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
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'We need your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: '******',
                      labelText: 'Password *',
                    ),
                    validator: (value) {
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
                          color: Colors.blueAccent[600],
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
