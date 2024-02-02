import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/order_list.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/order_screen.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/products_overview_screen.dart';
import 'package:shopping/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      fontFamily: 'Lato',
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.primary),
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.deepOrange,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          textTheme: const TextTheme().copyWith(
              titleLarge: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
              ),
              titleMedium: const TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
              )),
        ),
        // home: const ProductsOverviewScreen(),
        routes: {
          AppRoutes.productsOverview: (_) => const ProductsOverviewScreen(),
          AppRoutes.productDetail: (_) => const ProductDetailScreen(),
          AppRoutes.cart: (_) => const CartSreen(),
          AppRoutes.order: (_) => const OrderScreen(),
        },
        initialRoute: AppRoutes.productsOverview,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
