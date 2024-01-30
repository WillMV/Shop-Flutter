import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/models/product_model.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  bool _showOnlyFavorites = false;

  List<Product> get items => _showOnlyFavorites
      ? _items.where((e) => e.isFavorite).toList()
      : [..._items];

  void showOnlyFavorites(bool value) {
    _showOnlyFavorites = value;
    notifyListeners();
  }
}
