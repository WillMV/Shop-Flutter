import 'package:flutter/material.dart';
import 'package:shopping/widget/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const ProductsGrid(),
    );
  }
}
