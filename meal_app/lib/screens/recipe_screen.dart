import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets/recipe_item.dart';
import '../dummy-data.dart';
import '../models/recipe.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class recipe_screen extends StatefulWidget {
  static String routename = '/recipe-screen';
  final List<recipe> availablerecipes;
  recipe_screen(this.availablerecipes);
  @override
  State<recipe_screen> createState() => _recipe_screenState();
}

class _recipe_screenState extends State<recipe_screen> {
  late List<recipe> DisplayMeal;
  late String CategTitle;
  bool isloaded = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!isloaded) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
      final String id = routeArgs['id'] as String;
      CategTitle = routeArgs['title'] as String;
      DisplayMeal = widget.availablerecipes.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      isloaded = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealid) {
    setState(() {
      DisplayMeal.removeWhere((element) => element.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(CategTitle),
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return recipe_item(
              id: DisplayMeal[index].id,
              title: DisplayMeal[index].title,
              imageUrl: DisplayMeal[index].imageUrl,
              affordability: DisplayMeal[index].affordability,
              complexity: DisplayMeal[index].complexity,
              duration: DisplayMeal[index].duration,
            );
          }),
          itemCount: DisplayMeal.length,
        ));
  }
}
