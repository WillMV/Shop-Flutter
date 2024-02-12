import 'package:flutter/material.dart';
import 'package:shopping/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text(
            'Wellcome',
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
                context, AppRoutes.PRODUCTS_OVERVIEW);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.restorablePushReplacementNamed(context, AppRoutes.ORDER);
          },
          leading: const Icon(Icons.credit_card),
          title: const Text('Orders'),
        ),
        ListTile(
          onTap: () => Navigator.restorablePushReplacementNamed(
              context, AppRoutes.PRODUCTS),
          leading: const Icon(Icons.create_sharp),
          title: const Text('Manage products'),
        )
      ]),
    );
  }
}
