import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';

class productDetails extends StatelessWidget {
  static String routeName = "/product-details";
  const productDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments.toString();
    final loadedProduct = Provider.of<Products>(context).findProdById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text("Unable To Load Image"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "₹${loadedProduct.price}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
    );
  }
}
