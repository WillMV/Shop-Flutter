import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/order_model.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    Order order = Provider.of<Order>(context);
    return Card(
      child: Padding(
        padding: expanded
            ? const EdgeInsets.only(bottom: 8.0)
            : const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'R\$ ${order.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lato',
                ),
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(order.date).toString(),
              ),
              trailing: IconButton(
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
              ),
            ),
            if (expanded)
              ...order.productList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${e.quantity}x R\$ ${e.price}',
                            style: const TextStyle(
                                color: Colors.black87, fontFamily: 'lato'),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
          ],
        ),
      ),
    );
  }
}
