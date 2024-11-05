import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repository/Api/api.dart';
import '../Repository/ModelClass/LoginModel.dart';


class AuthProvider with ChangeNotifier {
  final Api _authApi = Api();
  UserModel? _user;
  String? _errorMessage;

  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    final token = await _authApi.login(email, password);

    if (token != null) {
      _user = UserModel();
      _errorMessage = null;

      // Save token to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _user!.accessToken.toString());

      notifyListeners();
    } else {
      _errorMessage = 'Login failed. Please check your credentials.';
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
