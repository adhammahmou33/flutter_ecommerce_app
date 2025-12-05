import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'app.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(


      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),

      ],
      child: App(),

    );
  }
}