import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Widgets/cartTile.dart';

class cartScreen extends StatefulWidget {
  static String routeName = '/cart-screen';

  const cartScreen({super.key});

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
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "₹ ${cart.cartValue.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.black),
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

                              const snack = SnackBar(
                                content: Text("Order Placed"),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Order Now",
                              style: TextStyle(color: Colors.black),
                            ))
                ],
              ),
            ),
          ),
          const SizedBox(
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
