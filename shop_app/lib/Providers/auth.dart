import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String? _token = null;
  late DateTime? _expiry = null;
  late String? _userId;
  static const String _apikey = 'Your Api Key';
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiry != null && _expiry!.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
  }

  Future<void> signUp(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apikey";
    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
  }

  Future<void> login(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apikey";
    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    _token = responseData['idToken'];
    _expiry = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _userId = responseData['localId'];
    notifyListeners();
  }
}
