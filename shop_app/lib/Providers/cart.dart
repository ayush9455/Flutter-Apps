import 'package:flutter/material.dart';

class cartItem {
  final String id;
  final String title;
  final double quantity;
  final double price;

  cartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, cartItem> _items = {};

  Map<String, cartItem> get item {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  double get cartValue {
    double val = 0.0;
    _items.forEach((key, cartItem) {
      val += cartItem.price * cartItem.quantity;
    });
    return val;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => cartItem(
              id: existingItem.id,
              title: existingItem.title,
              quantity: existingItem.quantity + 1,
              price: existingItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => cartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingle(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingItem) => cartItem(
              id: existingItem.id,
              title: existingItem.title,
              quantity: existingItem.quantity - 1,
              price: existingItem.price));
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }
}
