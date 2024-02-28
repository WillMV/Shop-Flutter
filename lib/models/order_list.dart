import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping/models/cart_item_model.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_model.dart';
import 'package:shopping/utils/constants.dart';

class OrderList with ChangeNotifier {
  final _dio = Dio(BaseOptions(
    baseUrl: Constants.USER_ORDERS_URL,
  ));

  final String _token;
  final String _userId;
  final List<Order> _items;

  OrderList(this._token, this._userId, this._items);

  List<Order> get items => [..._items];

  Future<void> getOrdersByDb() async {
    try {
      Response response = await _dio.get('/$_userId.json?auth=$_token');
      Map data = response.data ?? {};
      _items.clear();
      data.forEach(
        (key, value) {
          List<dynamic> prodList = value['productList'];
          List<CartItemModel> productList = prodList
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

      Response response = await _dio.post('/$_userId.json?auth=$_token', data: {
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
