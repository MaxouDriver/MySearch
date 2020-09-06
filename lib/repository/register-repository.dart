import 'package:MySearch/models/Auth/login-response.dart';
import 'package:MySearch/models/server-response.dart';
import 'package:MySearch/utils/RequestManager.dart';

class RegisterRepository {
  Future<ServerResponse> register(email, password, context) async {
    try {
      var response = await RequestManager.post(context, 'auth/register',
          <String, String>{'email': email, 'passwd': password});
      ServerResponse apiResponseModel = LoginResponse.fromJson(response);
      return apiResponseModel;
    } catch (exception) {
      return ServerResponse(message: "Error", error: exception.toString());
    }
  }
}
