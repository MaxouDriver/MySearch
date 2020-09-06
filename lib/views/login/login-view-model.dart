import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/Ad/ad.dart';
import 'package:MySearch/repository/login-repository.dart';
import 'package:MySearch/repository/register-repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:MySearch/models/server-response.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel() {}

  List<Ad> ads;
  List<Ad> adsSinceLastConnection;
  String messageToShowAds = "";
  String messageToShowAdsSince = "";
  bool isLoadingAds = false;
  bool isLoadingAdsSince = false;

  Future<ServerResponse> login(email, password, context) async {
    /// Wait for response
    ServerResponse networkingResponse =
        await LoginRepository().login(email, password, context);
    print(networkingResponse.toString());
    return networkingResponse;
  }
}
