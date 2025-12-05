import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final product = id == null ? null : provider.findById(id);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Product detail')),
        body: Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.title)
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              placeholder: (c, s) =>
                  Container(height: 300, child: Center(child: CircularProgressIndicator())),
              errorWidget: (c, s, e) => Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Text(product.description),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: add to cart
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart (mock)')));
        },
        label: Text('Add to Cart'),
        icon: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
