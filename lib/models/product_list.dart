import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/models/product_model.dart';

class ProductList with ChangeNotifier {
  final _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favorites => items.where((e) => e.isFavorite).toList();
}
