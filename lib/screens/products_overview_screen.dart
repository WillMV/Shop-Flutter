import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/widget/app_drawer.dart';
import 'package:shopping/widget/cart_Icon.dart';
import 'package:shopping/widget/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductList>(context, listen: false);
    if (provider.items.isEmpty) {
      provider.getItemsByDB();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'My Shopping',
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
      ),
      body: RefreshIndicator(
          onRefresh: () => provider.getItemsByDB(),
          child: provider.items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : const ProductsGrid()),
    );
  }
}
