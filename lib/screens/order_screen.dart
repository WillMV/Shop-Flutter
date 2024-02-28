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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final OrderList provider = Provider.of(context, listen: false);
    if (provider.items.isEmpty) {
      provider.getOrdersByDb().then((value) => _notLoading());
    } else {
      _notLoading();
    }
  }

  // _loading() {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  _notLoading() {
    setState(() {
      isLoading = false;
    });
  }

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
                      child: const Text('Close'))
                ],
              ),
            );
          }),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : orderList.items.isEmpty
                  ? Center(
                      child: Text(
                        'Ainda não há pedidos realizados :(',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: orderList.items.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                        value: orderList.items.reversed.toList()[index],
                        builder: (context, child) => const OrderItem(),
                      ),
                    ),
        ));
  }
}
