import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/Ad/ad.dart';
import 'package:MySearch/repository/register-repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:MySearch/models/server-response.dart';
import 'package:MySearch/repository/home-repository.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel() {}

  List<Ad> ads;
  List<Ad> adsSinceLastConnection;
  String messageToShowAds = "";
  String messageToShowAdsSince = "";
  bool isLoadingAds = false;
  bool isLoadingAdsSince = false;

  void register(email, password, context) async {
    /// Start showing the loader
    isLoadingAds = true;
    notifyListeners();

    /// Wait for response
    ServerResponse networkingResponse =
        await RegisterRepository().register(email, password, context);

    /// We check the type of response and update the required field
    if (networkingResponse is AdResponse) {
      /// Updating the APIResponseModel when success
      ads = networkingResponse.ads;
    } else if (networkingResponse is ServerResponse) {
      /// Updating the errorMessage when fails
      messageToShowAds = networkingResponse.error;
    }

    /// Stop the loader
    isLoadingAds = false;
    notifyListeners();
  }
}
