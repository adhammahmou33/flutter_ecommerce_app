import 'dart:convert';
import '../models/product.dart';


class ApiService {
// Mock delay to simulate network
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(Duration(milliseconds: 800));


    final jsonStr = '''[
{"id":1,"title":"Sneakers","description":"Comfortable sneakers","price":59.99,"imageUrl":"https://picsum.photos/200/300?1"},
{"id":2,"title":"Backpack","description":"Travel backpack","price":79.50,"imageUrl":"https://picsum.photos/200/300?2"},
{"id":3,"title":"Watch","description":"Stylish watch","price":129.99,"imageUrl":"https://picsum.photos/200/300?3"}
]''';


    final List data = json.decode(jsonStr);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}