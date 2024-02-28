import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/auth_model.dart';
import 'package:shopping/screens/auth_form_screen.dart';
import 'package:shopping/screens/products_overview_screen.dart';

class AuthOrOverviewScreen extends StatelessWidget {
  const AuthOrOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error :('),
          );
        } else {
          return auth.token.isEmpty
              ? const AuthFormScreen()
              : const ProductsOverviewScreen();
        }
      },
    );
  }
}
