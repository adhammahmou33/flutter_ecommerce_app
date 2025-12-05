import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/screens/product_list_screen.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/models/product.dart';

void main() {
  group('Ecommerce App Widget Tests', () {
    late ProductProvider productProvider;
    late Product testProduct;

    setUp(() {
      // إنشاء Provider و منتج تجريبي
      productProvider = ProductProvider();
      testProduct = Product(
        id: '1',
        title: 'Test Product',
        description: 'Test Description',
        price: 9.99,
        imageUrl: 'https://via.placeholder.com/150',
      );
      productProvider.products.add(testProduct);// تأكد من دعم addProduct أو ضع مباشرة في _products
    });

    testWidgets('ProductListScreen displays product cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ProductProvider>.value(
          value: productProvider,
          child: MaterialApp(
            home: ProductListScreen(),
            routes: {
              '/product_detail': (context) => ProductDetailScreen(),
            },
          ),
        ),
      );

      // تحقق من ظهور المنتج في الشاشة
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('Tap on product navigates to ProductDetailScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ProductProvider>.value(
          value: productProvider,
          child: MaterialApp(
            home: ProductListScreen(),
            routes: {
              '/product_detail': (context) => ProductDetailScreen(),
            },
          ),
        ),
      );

      // اضغط على بطاقة المنتج
      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();

      // تحقق من الانتقال للشاشة الصحيحة
      expect(find.text('Test Product'), findsWidgets); // AppBar و body
      expect(find.text('\$9.99'), findsOneWidget);
    });

    testWidgets('Add to Cart button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ProductProvider>.value(
          value: productProvider,
          child: MaterialApp(
            home: ProductDetailScreen(),
            routes: {
              '/product_detail': (context) => ProductDetailScreen(),
            },
            initialRoute: '/product_detail',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => ProductDetailScreen(),
                settings: RouteSettings(arguments: '1'),
              );
            },
          ),
        ),
      );

      // اضغط على زر Add to Cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // تحقق من ظهور Snackbar
      expect(find.text('Added to cart (mock)'), findsOneWidget);
    });
  });
}
