import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:http/http.dart' as http;

class orderItem {
  final String id;
  final double amount;
  final DateTime date;
  final List<cartItem> products;
  orderItem(
      {required this.id,
      required this.amount,
      required this.date,
      required this.products});
}

class Orders with ChangeNotifier {
  List<orderItem> _orderitems = [];
  List<orderItem> get item {
    return [..._orderitems];
  }

  final String token;
  Orders(this.token, this._orderitems);

  List<orderItem> get orders {
    return [..._orderitems];
  }

  Future<void> FetchAndLoad() async {
    final url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/orders.json?auth=$token';
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == Null) {
      return;
    }
    final List<orderItem> loadedOrders = [];
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(orderItem(
          id: orderId,
          amount: orderData['amount'],
          date: DateTime.parse(orderData['date']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => cartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList()));
    });
    _orderitems = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<cartItem> cartprod, double amt) async {
    final url =
        'https://shopapp-dc723-default-rtdb.firebaseio.com/orders.json?auth=$token';
    final timestamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': amt,
          'date': timestamp.toIso8601String(),
          'products': cartprod
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));
    _orderitems.insert(
        0,
        orderItem(
            id: jsonDecode(response.body)['name'],
            amount: amt,
            date: timestamp,
            products: cartprod));
    notifyListeners();
  }

  void removeOrder(String prodId) {
    _orderitems.remove(prodId);
    notifyListeners();
  }

  void clearOrder() {
    _orderitems = [];
    notifyListeners();
  }

  int get itemCount {
    return _orderitems.length;
  }
}
