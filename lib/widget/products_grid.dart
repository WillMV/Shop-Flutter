import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/widget/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final products = provider.products;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        childAspectRatio: 1,
        mainAxisSpacing: 15,
      ),
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final item = products[index];
        return ChangeNotifierProvider(
          create: (context) => item,
          child: const ProductItem(),
        );
      },
    );
  }
}
