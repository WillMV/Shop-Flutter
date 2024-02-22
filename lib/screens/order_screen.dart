import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/widget/app_drawer.dart';
import 'package:shopping/widget/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);

    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text(
            'Orders',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => orderList.getOrdersByDb().catchError((error) {
            return showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error!!!'),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ok ;-;'))
                ],
              ),
            );
          }),
          child: ListView.builder(
            itemCount: orderList.items.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: orderList.items[index],
              builder: (context, child) => const OrderItem(),
            ),
          ),
        ));
  }
}
