import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import 'package:shop_app/Screens/cartScreen.dart';
import 'package:shop_app/Screens/ordersScreen.dart';
import 'package:shop_app/Widgets/badge.dart';
import 'package:shop_app/Screens/drawerScreen.dart';
import '../Providers/products.dart';
import '../Widgets/productItem.dart';
import './products_overview_screen.dart';
import '../Widgets/productGrid.dart';
// import 'dart:ffi';
import '../Providers/cart.dart';

enum filterOpt { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).FetchAndLoad().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  var showfav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("MY SHOP",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == filterOpt.Favourites)
                    showfav = true;
                  else
                    showfav = false;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Only Favourites"),
                      value: filterOpt.Favourites,
                    ),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: filterOpt.All,
                    )
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => badge(
                color: Colors.black54,
                value: cart.itemCount.toString(),
                child: ch!),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(cartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: Drawer_Screen(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : ProductGrid(showfav),
    );
  }
}
