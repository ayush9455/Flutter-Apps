import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';

class cartTile extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final double quantity;
  final String productId;
  const cartTile(
      {super.key, required this.title,
      required this.price,
      required this.quantity,
      required this.id,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Are You Sure !"),
                  content: const Text("Do You Want To Remove Item From Cart !"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("YES")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("NO")),
                  ],
                ));
      },
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.all(3),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, size: 30),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              foregroundColor: Colors.white,
              child: FittedBox(child: Text("₹$price")),
            ),
            title: Text(title),
            subtitle: Text("Total : ${price * quantity}"),
            trailing: Text(
              "$quantity x",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
