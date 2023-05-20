// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import 'package:shop_app/Screens/AddProductScreen.dart';
import 'package:shop_app/Screens/drawerScreen.dart';
import 'package:shop_app/Widgets/userProduct.dart';

class userProductScreen extends StatelessWidget {
  static String routeName = "/product-screen";

  const userProductScreen({super.key});
  Future<void> _refreshFunction(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).FetchAndLoad(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productItems = Provider.of<Products>(context);
    return Scaffold(
      drawer: const Drawer_Screen(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(addProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _refreshFunction(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshFunction(context),
                    child: Consumer<Products>(
                      builder: (context, productItems, _) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListView.builder(
                          itemBuilder: (_, i) => userProduct(
                              productItems.items[i].id,
                              productItems.items[i].imageUrl,
                              productItems.items[i].title),
                          itemCount: productItems.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
