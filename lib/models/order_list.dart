import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_model.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  void addOrder(Cart cart) {
    final order = Order(
      orderId: Random().nextDouble().toString(),
      totalPrice: cart.fullPrice,
      date: DateTime.now(),
      productList: cart.items,
    );
    print(order.orderId.toString());
    _items.add(order);

    notifyListeners();
  }
}
