import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String txt;
  final VoidCallback ontap;
  const CustomButton({super.key, required this.txt, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: ontap,
        child: Text(txt),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ));
  }
}
