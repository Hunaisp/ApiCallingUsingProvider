import 'dart:convert';

import 'package:http/http.dart';

import '../ModelClass/CategoryModel.dart';
import '../ModelClass/LoginModel.dart';
import 'api_client.dart';

class Api {
  ApiClient apiClient = ApiClient();
//login api
  Future<UserModel>  login(
    String email,
    String password,
  ) async {
    String path = 'https://api.escuelajs.co/api/v1/auth/login';
    var body = {"email": email, "password": password};
    Response response = await apiClient.invokeAPI(path, 'POST', jsonEncode(body));



    return UserModel.fromJson(jsonDecode(response.body));
  }

  //category api
  Future<List<CategoryModel>>  getCategory(

      ) async {
    String path = 'https://prethewram.pythonanywhere.com/api/parts_categories/';
    var body = {};
    Response response = await apiClient.invokeAPI(path, 'GET',body);



    return CategoryModel.listFromJson(jsonDecode(response.body));
  }
}
