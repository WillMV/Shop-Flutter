import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/widget/products_grid.dart';


class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping'),
        actions: [
          PopupMenuButton(
            iconColor: Colors.black87,
            onSelected: (value) {
              provider.showOnlyFavorites(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: true,
                child: Text('Show Favorites'),
              ),
              const PopupMenuItem(
                value: false,
                child: Text('Show All'),
              )
            ],
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const ProductsGrid(),
    );
  }
}
