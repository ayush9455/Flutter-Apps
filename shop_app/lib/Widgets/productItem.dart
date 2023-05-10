import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/auth.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/productDetails.dart';
import '../Screens/productDetails.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, _) => Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(productDetails.routeName, arguments: product.id);
            },
            child: GridTile(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white10,
                  child: Center(
                    child: Text("Unable To Load Image"),
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                leading: IconButton(
                    onPressed: () {
                      product.toggleFavourite(auth.token!);
                    },
                    icon: product.isFavourite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border)),
                trailing: IconButton(
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                      var showSnackBar;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Item Added To Cart"),
                        action: SnackBarAction(
                            label: "Undo",
                            onPressed: () {
                              cart.removeSingle(product.id);
                            }),
                      ));
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
