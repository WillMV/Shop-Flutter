import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/utils/routes.dart';
import 'package:shopping/widget/app_drawer.dart';
import 'package:shopping/widget/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductList provider = Provider.of<ProductList>(context);
    List<Product> products = provider.items;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.PRODUCT_FORM),
              icon: const Icon(Icons.add))
        ],
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(product: products[index]);
          },
        ),
      ),
    );
  }
}
