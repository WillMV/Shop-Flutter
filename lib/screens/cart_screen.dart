import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/cart_item_model.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/widget/cart_item.dart';

class CartSreen extends StatefulWidget {
  const CartSreen({super.key});

  @override
  State<CartSreen> createState() => _CartSreenState();
}

class _CartSreenState extends State<CartSreen> {
  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context);

    final List<CartItemModel> items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 10),
                    Chip(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: Text(
                        'R\$ ${cart.fullPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          if (cart.items.isNotEmpty) {
                            orderList.addOrder(cart);
                            cart.clear();
                          }
                        },
                        child: const Text('Buy')),
                  ]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider.value(
                value: items[index],
                child: const CartItem(),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
