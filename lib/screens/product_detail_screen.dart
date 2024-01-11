import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(product.imageUrl),
          Text(
            'R\$ ${product.price.toString()}',
            style: const TextStyle(color: Colors.grey, fontSize: 25),
          ),
          Text(product.description)
        ]),
      ),
    );
  }
}
