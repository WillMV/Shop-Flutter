import 'package:flutter/material.dart';
import 'package:shopping/models/cart_item_model.dart';
import 'package:shopping/models/product_model.dart';

class Cart with ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items {
    return _items;
  }

  double get fullPrice {
    double result = 0;

    for (CartItemModel element in _items) {
      result += element.fullPrice;
    }

    return result;
  }

  void addItem(Product item) {
    bool itemFound = false;

    for (CartItemModel element in _items) {
      if (element.id == item.id) {
        element.quantity++;
        itemFound = true;
        break;
      }
    }

    if (!itemFound) {
      _items.add(CartItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeItem(CartItemModel item) {
    _items.remove(item);
    notifyListeners();
  }
}
