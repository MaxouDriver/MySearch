import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/Ad/ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:MySearch/models/server-response.dart';
import 'package:MySearch/repository/home-repository.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(context) {
    /// As soon as VM initializes
    /// We want to get the latest data
    getSearchsFromAPI(context);
  }

  List<Ad> ads;
  String messageToShow = "";
  bool isLoading = false;

  void getSearchsFromAPI(context) async {
    /// Start showing the loader
    isLoading = true;
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
      messageToShow = networkingResponse.error;
    }

    /// Stop the loader
    isLoading = false;
    notifyListeners();
  }
}
