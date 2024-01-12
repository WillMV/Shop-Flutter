import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../models/product_list.dart';
import '../widget/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final products = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GridView.builder(
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
            child: ProductItem(),
          );
        },
      ),
    );
  }
}
