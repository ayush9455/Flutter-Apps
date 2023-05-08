import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Screens/ordersScreen.dart';
import 'package:shop_app/Screens/productDetails.dart';
import 'package:shop_app/Screens/userProductScreen.dart';

class Drawer_Screen extends StatelessWidget {
  const Drawer_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hi, Ayush"),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Your Orders"),
            onTap: () {
              Navigator.of(context).pushNamed(ordersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.of(context).pushNamed(userProductScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
