import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/models/product_model.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  bool _showOnlyFavorites = false;

  List<Product> get items => _showOnlyFavorites
      ? _items.where((e) => e.isFavorite).toList()
      : [..._items];

  void addItem(Product item) {
    if (!_items.any((element) => element.title == item.title)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void showOnlyFavorites(bool value) {
    _showOnlyFavorites = value;
    notifyListeners();
  }

  void updateProduct(Product item) {
    _items.removeWhere((element) => element.id == item.id);
    _items.add(item);
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
