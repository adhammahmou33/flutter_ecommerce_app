import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchAll(),
        child: provider.loading
            ? Center(child: CircularProgressIndicator())
            : provider.error != null
            ? Center(child: Text('Error: ${provider.error}'))
            : GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: provider.products.length,
          itemBuilder: (ctx, i) {
            final p = provider.products[i];
            return ProductCard(
              product: p,
              onTap: () =>
                  Navigator.pushNamed(context, '/product_detail', arguments: p.id),
            );
          },
        ),
      ),
    );
  }
}
