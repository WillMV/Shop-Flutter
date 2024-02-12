import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/data/dummy_products.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/utils/environment_variables.dart';

class ProductList with ChangeNotifier {
  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env[EnvironmentConfig.BASE_URL]!,
  ));

  final List<Product> _items = [];

  final String _path = '/products';

  bool _showOnlyFavorites = false;

  List<Product> get items {
    if (_showOnlyFavorites) {
      return _items.where((element) => element.isFavorite).toList();
    } else {
      return [..._items];
    }
  }

  void showOnlyFavorites(bool value) {
    _showOnlyFavorites = value;
    notifyListeners();
  }

  Future<void> saveItem(Map<String, Object> data) async {
    if (data['id'] != null) {
      await updateItem(data);
    } else {
      await addItem(data);
    }
    notifyListeners();
  }

  Future<void> addItem(Map<String, Object> data) async {
    if (!_items.any((element) => element.title == data['title'])) {
      Response response = await _dio.post(
        '$_path.json',
        options: Options(contentType: 'application/json'),
        data: {...data, 'isFavorite': false},
      );
      _items.add(Product(
          id: response.data['name'],
          title: data['title'] as String,
          imageUrl: data['imageUrl'] as String,
          description: data['description'] as String,
          price: data['price'] as double));
    }
  }

  Future<void> updateItem(Map<String, Object> data) async {
    await _dio.put('$_path/${data['id']}.json', data: data);
    _items.removeWhere((element) => element.id == data['id']);
    _items.add(Product(
      id: data['id'] as String,
      title: data['title'] as String,
      imageUrl: data['imageUrl'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
    ));
  }

  void deleteItem(String id) async {
    try {
      await _dio.delete('$_path/$id.json');
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('deleteItem().error ${e.toString()}');
      }
    }
  }

  getItemsByDB() async {
    try {
      final Response response = await _dio.get('$_path.json');
      final Map data = response.data;
      data.forEach((key, value) {
        _items.add(Product(
          id: key,
          title: value['title'],
          imageUrl: value['imageUrl'],
          description: value['description'],
          price: value['price'],
          isFavorite: value['isFavorite'],
        ));
      });
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('getItemsByDB.error: ${e.toString()}');
      }
    }
  }
}
