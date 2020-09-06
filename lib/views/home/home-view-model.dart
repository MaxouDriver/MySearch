import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/Ad/ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:MySearch/models/server-response.dart';
import 'package:MySearch/repository/home-repository.dart';

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel(context) {
    /// As soon as VM initializes
    /// We want to get the latest data
    getAdsFromAPI(context);
    getAdsSinceLastConnexionFromAPI(context);
  }

  List<Ad> ads;
  List<Ad> adsSinceLastConnection;
  String messageToShowAds = "";
  String messageToShowAdsSince = "";
  bool isLoadingAds = false;
  bool isLoadingAdsSince = false;

  void getAdsFromAPI(context) async {
    /// Start showing the loader
    isLoadingAds = true;
    notifyListeners();

    /// Wait for response
    ServerResponse networkingResponse =
        await HomeScreenRepository().getLatestDataFromAPI(context);

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

  void getAdsSinceLastConnexionFromAPI(context) async {
    /// Start showing the loader
    isLoadingAdsSince = true;
    notifyListeners();

    /// Wait for response
    ServerResponse networkingResponse =
        await HomeScreenRepository().getLatestDataFromAPI(context);

    /// We check the type of response and update the required field
    if (networkingResponse is AdResponse) {
      /// Updating the APIResponseModel when success
      adsSinceLastConnection = networkingResponse.ads;
    } else if (networkingResponse is ServerResponse) {
      /// Updating the errorMessage when fails
      messageToShowAdsSince = networkingResponse.error;
    }

    /// Stop the loader
    isLoadingAdsSince = false;
    notifyListeners();
  }
}
