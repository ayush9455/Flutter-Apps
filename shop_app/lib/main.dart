import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: AuthScreen(),
        routes: {
          productDetails.routeName: (context) => productDetails(),
          cartScreen.routeName: (context) => cartScreen(),
          ordersScreen.routeName: (context) => ordersScreen(),
          userProductScreen.routeName: (context) => userProductScreen(),
          addProductScreen.routeName: (context) => addProductScreen(),
          editProductScreen.routeName: (context) => editProductScreen(),
        },
      ),
    );
  }
}
