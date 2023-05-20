import 'dart:convert';

import 'package:amazon_clone/constants/errorhandling.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpService({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');
      final response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          context: context,
          response: response,
          onSuccess: () {
            showSnackBar(context, 'Account Created ! Login Now');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInService({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final responseData = json.decode(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          context: context,
          response: response,
          onSuccess: () async {
            showSnackBar(context, 'Logged In Succesfully');
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('token', responseData['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(token);
      if (token == null) {
        prefs.setString('token', '');
      }
      final tokenResponse = await http.post(
        Uri.parse('$uri/api/istokenValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
      );

      final tokenResponseData = json.decode(tokenResponse.body);

      if (tokenResponseData == true) {
        //get user data
        final response = await http.get(
          Uri.parse(
            '$uri/',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token
          },
        );

        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
