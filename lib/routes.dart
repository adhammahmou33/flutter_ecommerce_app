import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => HomeScreen(),
  '/products': (_) => ProductListScreen(),
  '/product_detail': (_) => ProductDetailScreen(),
};