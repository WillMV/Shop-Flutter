import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/utils/environment_variables.dart';

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

  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env[EnvironmentConfig.BASE_URL]!,
  ));
  final String _path = '/products';

  void toogleFavorite() async {
    isFavorite = !isFavorite;
    _dio.put('$_path/$id.json', data: {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'isFavorite': isFavorite,
    });
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
      'price': price,
      'isFavorite': isFavorite,
    };
  }
}
