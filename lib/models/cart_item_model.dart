import 'package:flutter/material.dart';

class CartItemModel with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  double get fullPrice {
    return price * quantity;
  }

  @override
  String toString() {
    return '{ id: $id,\n title: $title,\n price:$price,\n fullPrice: $fullPrice,\n quantity: $quantity } \n';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'quantity': quantity};
  }
}
