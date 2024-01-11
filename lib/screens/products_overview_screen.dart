import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/screens/product_detail_screen.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Text(
                  item.title,
                  textAlign: TextAlign.center,
                ),
                trailing: const Icon(Icons.shopping_cart),
                leading: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                            product: item,
                          )));
                },
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final products = dummyProducts;
