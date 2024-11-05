import 'package:flutter/material.dart';
import 'package:providerapi/Repository/ModelClass/CategoryModel.dart';

import '../Repository/Api/api.dart';


class CategoryProvider with ChangeNotifier {
  final Api _categoryApi = Api();
  List<CategoryModel> _categories = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _categoryApi.getCategory();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
