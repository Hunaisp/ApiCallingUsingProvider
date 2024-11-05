import 'package:flutter/material.dart';

import '../Repository/Api/api.dart';
import '../Repository/ModelClass/ProductModel.dart';


class ProductProvider with ChangeNotifier {
  final Api _productApi = Api();
  List<ProductModel> _products = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productApi.getProducts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
