import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import 'package:shop_app/Screens/cartScreen.dart';

import 'package:shop_app/Widgets/badge.dart';
import 'package:shop_app/Screens/drawerScreen.dart';

import '../Widgets/productGrid.dart';
import '../Providers/cart.dart';

enum filterOpt { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showfav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text("MY SHOP",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == filterOpt.Favourites) {
                    showfav = true;
                  } else {
                    showfav = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: filterOpt.Favourites,
                      child: Text("Only Favourites"),
                    ),
                    const PopupMenuItem(
                      value: filterOpt.All,
                      child: Text("Show All"),
                    )
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => badge(
                color: Colors.black54,
                value: cart.itemCount.toString(),
                child: ch!),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(cartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const Drawer_Screen(),
      body: FutureBuilder(
          future: Provider.of<Products>(context, listen: false).FetchAndLoad(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : ProductGrid(showfav)),
    );
  }
}
