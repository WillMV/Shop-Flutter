import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/auth_model.dart';
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
            Navigator.restorablePushReplacementNamed(context, AppRoutes.HOME);
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
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Provider.of<Auth>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, AppRoutes.HOME);
          },
        )
      ]),
    );
  }
}
