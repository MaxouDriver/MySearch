import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/utils/RequestManager.dart';
import 'package:MySearch/models/server-response.dart';

class SearchRepository {
  Future<ServerResponse> getSearchFromAPI(context) async {
    try {
      Map<String, dynamic> response = await RequestManager.get(context, "ads");
      ServerResponse apiResponseModel = AdResponse.fromJson(response);
      return apiResponseModel;
    } catch (exception) {
      return ServerResponse(message: "Error", error: exception.toString());
    }
  }
}
