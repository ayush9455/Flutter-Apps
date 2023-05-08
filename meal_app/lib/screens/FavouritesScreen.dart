import 'package:flutter/material.dart';
import 'package:meal_app/widgets/recipe_item.dart';
import '../models/recipe.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meal_app/screens/drawerScreen.dart';

class FavouritesScreen extends StatelessWidget {
  List<recipe> favMeals;
  FavouritesScreen(this.favMeals);
  @override
  Widget build(BuildContext context) {
    return (favMeals.isEmpty)
        ? Center(
            child: Text('No Favourites Added !'),
          )
        : ListView.builder(
            itemBuilder: ((context, index) {
              return recipe_item(
                id: favMeals[index].id,
                title: favMeals[index].title,
                imageUrl: favMeals[index].imageUrl,
                affordability: favMeals[index].affordability,
                complexity: favMeals[index].complexity,
                duration: favMeals[index].duration,
              );
            }),
            itemCount: favMeals.length,
          );
  }
}
