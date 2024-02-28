import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/utils/constants.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items;
  final String _token;
  final String _userId;

  final _dio = Dio();

  bool _showOnlyFavorites = false;

  ProductList(
    this._token,
    this._userId,
    this._items,
  );

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
        '${Constants.PRODUCTS_URL}.json?auth=$_token',
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
    await _dio.put('${Constants.PRODUCTS_URL}/${data['id']}.json?auth=$_token',
        data: data);
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
      await _dio.delete('${Constants.PRODUCTS_URL}/$id.json?auth=$_token');
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('deleteItem().error ${e.toString()}');
      }
    }
  }

  Future<void> getItemsByDB() async {
    final Response items =
        await _dio.get('${Constants.PRODUCTS_URL}.json?auth=$_token',
            options: Options(
              validateStatus: (status) => true,
            ));

    final Response favorites = await _dio
        .get('${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token');

    final Map<String, dynamic> data = items.data ?? {};
    final Map<String, dynamic> favs = favorites.data ?? {};

    if (data['error'] != null) {
      // se error = "Permission denied" avisar que necessario realizar login novamente e fazer logout do usuario
      return;
    }

    _items.clear();

    data.forEach((key, value) {
      Product prod = Product(
        id: key,
        title: value['title'],
        imageUrl: value['imageUrl'],
        description: value['description'],
        price: value['price'],
        isFavorite: favs[key] ?? false,
      );
      _items.add(prod);
    });

    notifyListeners();
  }
}
