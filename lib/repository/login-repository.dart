import 'package:MySearch/models/Ad/ad-response.dart';
import 'package:MySearch/models/Auth/login-response.dart';
import 'package:MySearch/utils/RequestManager.dart';
import 'package:MySearch/models/server-response.dart';

class LoginRepository {
  Future<ServerResponse> login(email, password, context) async {
    try {
      var response = await RequestManager.post(context, 'auth/login',
          <String, String>{'email': email, 'passwd': password});
      print("login-respository.dart - line 11: " + response.toString());
      ServerResponse apiResponseModel = LoginResponse.fromJson(response);
      return apiResponseModel;
    } catch (exception) {
      print("login-respository.dart - line 15: " + exception.toString());
      return ServerResponse(message: "Error", error: exception.toString());
    }
  }
}
