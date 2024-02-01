import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/utils/routes.dart';
import 'package:shopping/widget/app_drawer.dart';
import 'package:shopping/widget/cart_Icon.dart';
import 'package:shopping/widget/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          'My Shopping',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton(
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
          ),
          const CartIcon()
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const ProductsGrid(),
    );
  }
}
