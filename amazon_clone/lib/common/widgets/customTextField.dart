import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTxt;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintTxt,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hintTxt == 'Password' ? true : false,
      decoration: InputDecoration(
          hintText: hintTxt,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your $hintTxt';
        }
        return null;
      },
    );
  }
}
