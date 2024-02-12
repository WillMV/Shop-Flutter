import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });

  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  @override
  String toString() {
    return 'title: $title, id: $id, description: $description, imageUr:l $imageUrl, isFavorite: $isFavorite, price: $price';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price.toString(),
      'isFavorite': isFavorite.toString(),
    };
  }
}
