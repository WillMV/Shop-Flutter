import 'package:flutter/material.dart';
import 'package:shopping/models/cart_item_model.dart';

class Order with ChangeNotifier {
  final String orderId;
  final double totalPrice;
  final DateTime date;
  final List<CartItemModel> productList;

  Order({
    required this.orderId,
    required this.totalPrice,
    required this.date,
    required this.productList,
  });
}
