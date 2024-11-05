import 'dart:convert';

import 'package:http/http.dart';

import '../ModelClass/LoginModel.dart';
import 'api_client.dart';

class MesCartApi {
  ApiClient apiClient = ApiClient();

  Future<UserModel>  mesKartSignup(
    String email,
    String password,
  ) async {
    String path = 'https://api.escuelajs.co/api/v1/auth/login';
    var body = {"email": email, "password": password};
    Response response = await apiClient.invokeAPI(path, 'POST', jsonEncode(body));



    return UserModel.fromJson(jsonDecode(response.body));
  }
}
