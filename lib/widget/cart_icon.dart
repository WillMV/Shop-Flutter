import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/utils/routes.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context);

    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.CART),
          icon: const Icon(
            Icons.shopping_cart,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            width: 19,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              cartItems.items.length.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
