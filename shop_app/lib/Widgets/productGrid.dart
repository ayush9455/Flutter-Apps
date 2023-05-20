// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import '../Providers/products.dart';
import './productItem.dart';

class ProductGrid extends StatelessWidget {
  late List<Product> loaded;
  var showfav = false;
  ProductGrid(this.showfav, {super.key});
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<Products>(context);
    loaded = showfav ? dataProvider.fav : dataProvider.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 4 / 3),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loaded[index],
        child: const ProductItem(),
      ),
      itemCount: loaded.length,
    );
  }
}
