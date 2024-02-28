import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping/utils/constants.dart';

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
    baseUrl: Constants.USER_FAVORITES_URL,
  ));

  Future<void> getfavoriteValue(String token, String userId) async {
    try {
      Response response = await _dio.get('/$userId/$id.json?auth=$token');
      isFavorite = response.data ?? false;
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    }
  }

  void toogleFavorite(String token, String userId) async {
    isFavorite = !isFavorite;
    Response res = await _dio.patch('/$userId.json?auth=$token',
        options: Options(
          validateStatus: (status) => true,
        ),
        data: {
          id: isFavorite,
        });

    if (res.data['error'] != null) {
      isFavorite = !isFavorite;
    }
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
    };
  }
}
