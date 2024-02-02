import 'package:flutter/material.dart';
import 'package:shopping/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text(
            'Wellcome',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {
            Navigator.restorablePushReplacementNamed(
                context, AppRoutes.productsOverview);
          },
        ),
        const Divider(
          endIndent: 15,
          indent: 15,
        ),
        ListTile(
          onTap: () {
            Navigator.restorablePushReplacementNamed(context, AppRoutes.order);
          },
          leading: const Icon(Icons.credit_card),
          title: const Text('Orders'),
        )
      ]),
    );
  }
}
