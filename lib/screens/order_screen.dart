import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/models/order_model.dart';
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
          title: Text(
            'Orders',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: ListView.builder(
          itemCount: orderList.items.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: orderList.items[index],
            builder: (context, child) => const OrderItem(),
          ),
        ));
  }
}
