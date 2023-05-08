import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/cartTile.dart';

class cartScreen extends StatefulWidget {
  static String routeName = '/cart-screen';

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "₹ ${cart.cartValue.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.blueGrey[300],
                  ),
                  TextButton(
                    
                      onPressed: (cart.cartValue <= 0.00)
                          ? null
                          : () {
                              setState(() {
                                isLoading = true;
                              });
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                      cart.item.values.toList(), cart.cartValue)
                                  .then((_) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                              cart.clearCart();
                              final snack = SnackBar(
                                content: Text("Order Placed"),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Order Now",
                              style: TextStyle(color: Colors.black),
                            ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => cartTile(
                title: cart.item.values.toList()[index].title,
                price: cart.item.values.toList()[index].price,
                quantity: cart.item.values.toList()[index].quantity,
                id: cart.item.values.toList()[index].id,
                productId: cart.item.keys.toList()[index],
              ),
              itemCount: cart.item.length,
            ),
          ),
        ],
      ),
    );
  }
}
