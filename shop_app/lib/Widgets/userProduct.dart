import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import '../Screens/editProductScreen.dart';

class userProduct extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  const userProduct(this.id, this.imageUrl, this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          Navigator.of(context)
              .pushNamed(editProductScreen.routeName, arguments: id);
        },
        child: Card(
          child: ListTile(
            title: Text(title),
            leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
            trailing: IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    snackbar.hideCurrentSnackBar();
                    snackbar.showSnackBar(const SnackBar(
                      content: Text("Deletion Failed !"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                )),
          ),
        ));
  }
}
