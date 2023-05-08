// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import 'package:shop_app/Screens/AddProductScreen.dart';
import 'package:shop_app/Widgets/userProduct.dart';

class userProductScreen extends StatelessWidget {
  static String routeName = "/product-screen";
  Future<void> _refreshFunction(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).FetchAndLoad();
  }

  @override
  Widget build(BuildContext context) {
    final productItems = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(addProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshFunction(context),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: (_, i) => userProduct(productItems.items[i].id,
                productItems.items[i].imageUrl, productItems.items[i].title),
            itemCount: productItems.items.length,
          ),
        ),
      ),
    );
  }
}
