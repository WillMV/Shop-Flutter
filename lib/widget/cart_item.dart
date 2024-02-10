import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/cart_item_model.dart';
import 'package:shopping/models/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<CartItemModel>(context);
    final cart = Provider.of<Cart>(context);

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cart.removeItem(item),
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
            'Are you sure you want to remove the item?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'))
          ],
        ),
      ),
      background: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.price.toStringAsFixed(2)),
            )),
          ),
          title: Text(item.title),
          subtitle: Text('Total: R\$ ${item.fullPrice.toStringAsFixed(2)}'),
          trailing: Text('${item.quantity}x'),
        ),
      ),
    );
  }
}
