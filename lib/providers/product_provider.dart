import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';


class ProductProvider extends ChangeNotifier {
  final ApiService _api = ApiService();


  List<Product> _products = [];
  bool _loading = false;
  String? _error;


  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;


  ProductProvider() {
    fetchAll();
  }


  Future<void> fetchAll() async {
    _loading = true;
    _error = null;
    notifyListeners();


    try {
      _products = await _api.fetchProducts();
    } catch (e) {
      _error = e.toString();
      _products = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }


  Product? findById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}