import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/auth.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Providers/products_provider.dart';
import 'package:shop_app/Screens/AddProductScreen.dart';
import 'package:shop_app/Screens/authScreen.dart';
import 'package:shop_app/Screens/cartScreen.dart';
import 'package:shop_app/Screens/editProductScreen.dart';
import 'package:shop_app/Screens/ordersScreen.dart';
import 'package:shop_app/Screens/productDetails.dart';
import 'package:shop_app/Screens/userProductScreen.dart';
import 'Screens/productDetails.dart';
// import 'dart:ffi';
import 'Screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', []),
            update: (context, auth, previous) =>
                Products(auth.token!, previous == null ? [] : previous.items),
          ),
          // ProxyProvider<Auth, Products>(
          //     update: (context, auth, previous) => Products(
          //         auth.token!, previous == null ? [] : previous.items)),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('', []),
            update: (context, auth, previous) =>
                Orders(auth.token!, previous == null ? [] : previous.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Shop',
            theme: ThemeData(primarySwatch: Colors.blueGrey),
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              productDetails.routeName: (context) => productDetails(),
              cartScreen.routeName: (context) => cartScreen(),
              ordersScreen.routeName: (context) => ordersScreen(),
              userProductScreen.routeName: (context) => userProductScreen(),
              addProductScreen.routeName: (context) => addProductScreen(),
              editProductScreen.routeName: (context) => editProductScreen(),
            },
          ),
        ));
  }
}
