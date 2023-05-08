import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/Models/httpException.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});
  Future<void> toggleFavourite() async {
    final oldFav = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        isFavourite = oldFav;
        notifyListeners();
        throw httpException("Favourite Cant't Be Update !");
      }
    } catch (error) {
      isFavourite = oldFav;
      notifyListeners();
    }
  }
}
