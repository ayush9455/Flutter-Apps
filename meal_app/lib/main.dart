import 'package:flutter/material.dart';
import './dummy-data.dart';
import './models/recipe.dart';
import './screens/FilterSceen.dart';
import './screens/recipe_details.dart';
import './screens/recipe_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<recipe> availablerecipe = DUMMY_MEALS;
  List<recipe> favMeals = [];

  void _togglefav(String mealid) {
    final existingIndex =
        favMeals.indexWhere((element) => element.id == mealid);
    if (existingIndex >= 0) {
      setState(() {
        favMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealid));
      });
    }
  }

  bool _isFav(String mealid) {
    return favMeals.any((element) => element.id == mealid);
  }

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      availablerecipe = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) return false;
        if (_filters['lactose']! && !meal.isLactoseFree) return false;
        if (_filters['vegan']! && !meal.isVegan) return false;
        if (_filters['vegetarian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {
        '/': (context) => TabsScreen(favMeals),
        recipe_screen.routename: (context) => recipe_screen(availablerecipe),
        recipe_details.routeName: (context) =>
            recipe_details(_isFav, _togglefav),
        FilterScreen.routeName: (context) => FilterScreen(_filters, _setFilter),
      },
    );
  }
}
