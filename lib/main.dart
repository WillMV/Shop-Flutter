import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/auth_model.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/screens/auth_or_overview_screen.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/order_screen.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/product_form_screen.dart';
import 'package:shopping/screens/products_screen.dart';
import 'package:shopping/utils/routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      fontFamily: 'Lato',
      useMaterial3: true,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', '', []),
          update: (context, auth, previous) =>
              ProductList(auth.token, auth.userId, previous?.items ?? []),
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList('', '', []),
          update: (context, auth, previous) =>
              OrderList(auth.token, auth.userId, previous?.items ?? []),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).colorScheme.primary,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 24,
            ),
          ),
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.deepOrange,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        routes: {
          // AppRoutes.PRODUCTS_OVERVIEW: (_) => const ProductsOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (_) => const ProductDetailScreen(),
          AppRoutes.PRODUCT_FORM: (_) => const ProductFormScreen(),
          AppRoutes.PRODUCTS: (_) => const ProductsScreen(),
          AppRoutes.ORDER: (_) => const OrderScreen(),
          AppRoutes.CART: (_) => const CartSreen(),
          AppRoutes.HOME: (_) => const AuthOrOverviewScreen(),
        },
        initialRoute: AppRoutes.HOME,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
