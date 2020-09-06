import 'package:MySearch/views/register/register-view-model.dart';
import 'package:flutter/material.dart';
import 'package:MySearch/utils/AuthenticationManager.dart';
import 'package:stacked/stacked.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
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
    final _passwordConfirmationController = TextEditingController();

    void _onRegisterSuccess(BuildContext context, infos) {
      AuthenticationManager.login(infos);
      Navigator.pushReplacementNamed(context, '/');
    }

    void _onRegisterFailure(BuildContext context, message) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(message.toString()),
      ));
    }

    void _performRegistration(BuildContext context) {
      String email = _emailController.text;
      String password = _passwordController.text;

      viewModel.register(email, password, context).then((value) {
        print(value);
        print(value.error);
        return value.json["token"] != null
            ? _onRegisterSuccess(context, value.json)
            : _onRegisterFailure(context, value.error);
      }).catchError((error) => _onRegisterFailure(context, error));
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
                      return 'We need your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordConfirmationController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '******',
                    labelText: 'Password confirmation *',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'We need your confirmation password';
                    } else if (value != _passwordController.text) {
                      return "Passwords don\'t match";
                    } else {
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
        ));
  }
}
