import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/Models/httpException.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String? token;
  final String? userId;
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  Products(this.token, this.userId, this._items);
  List<Product> get items {
    return [..._items];
  }

  List<Product> get fav {
    return items.where((element) => element.isFavourite).toList();
  }

  Product findProdById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> FetchAndLoad([bool isFilter = false]) async {
    final String filterString =
        isFilter ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/products.json?auth=$token&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final List<Product> loadedProducts = [];
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }
      url =
          'https://shopapp-dc723-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$token';
      final favResponse = await http.get(Uri.parse(url));
      final favData = json.decode(favResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavourite: favData == null ? false : favData[prodId] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addItem(Product item) async {
    final url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': item.title,
            'description': item.description,
            'price': item.price,
            'imageUrl': item.imageUrl,
            'creatorId': userId,
          }));
      final newProduct = Product(
        id: jsonDecode(response.body)['name'],
        title: item.title,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        isFavourite: item.isFavourite,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product item) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      try {
        final url =
            'https://shopapp-dc723-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
        await http.patch(Uri.parse(url),
            body: json.encode({
              'title': item.title,
              'description': item.description,
              'price': item.price,
              'imageUrl': item.imageUrl,
            }));
        _items[prodIndex] = item;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        print("it should be readded");
        throw HttpException("Couldn't delete");
      }
    } catch (_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      rethrow;
    }
    existingProduct = null;
  }
}
