import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../screens/recipe_screen.dart';

class Category_item extends StatelessWidget {
  final String? id;
  final String? title;
  final color;

  Category_item(this.title, this.color, this.id);

  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(recipe_screen.routename,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => selectcategory(context),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          title as String,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
