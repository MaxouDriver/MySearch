import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/server-response.dart';
import 'package:MySearch/utils/RequestManager.dart';

class HomeScreenRepository {
  Future<ServerResponse> getLatestDataFromAPI(context) async {
    print("getLatestDataFromAPI");
    try {
      Map<String, dynamic> response = await RequestManager.get(context, "ads");
      print(response.toString());
      ServerResponse apiResponseModel = AdResponse.fromJson(response);
      return apiResponseModel;
    } catch (exception) {
      print(exception.toString());
      return ServerResponse(message: "Error", error: exception.toString());
    }
  }
}
