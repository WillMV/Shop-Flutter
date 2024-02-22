import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/models/cart_item_model.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_model.dart';
import 'package:shopping/utils/environment_variables.dart';

class OrderList with ChangeNotifier {
  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env[EnvironmentConfig.BASE_URL]!,
  ));

  List<Order> _items = [];

  List<Order> get items => [..._items];

  Future<void> getOrdersByDb() async {
    _items.clear();

    try {
      var response = await _dio.get('/orders.json');
      Map data = response.data;

      data.forEach(
        (key, value) {
          List<dynamic> prodList = value['productList'];
          var productList = prodList
              .map(
                (e) => CartItemModel(
                    id: e['id'],
                    title: e['title'],
                    price: e['price'],
                    quantity: e['quantity']),
              )
              .toList();

          _items.add(
            Order(
              orderId: key,
              totalPrice: value['totalPrice'],
              date: DateTime.parse(value['date']),
              productList: productList,
            ),
          );
        },
      );
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void addOrder(Cart cart) async {
    try {
      DateTime date = DateTime.now();
      double fullPrice = cart.fullPrice;

      Response response = await _dio.post('/orders.json', data: {
        'totalPrice': fullPrice,
        'date': date.toIso8601String(),
        'productList': cart.items.map((e) => e.toJson()).toList()
      });

      final order = Order(
        orderId: response.data['name'],
        totalPrice: fullPrice,
        date: date,
        productList: cart.items,
      );

      _items.add(order);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
