import 'package:flutter/material.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import './FilterSceen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.cyan[300],
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Color.fromARGB(255, 53, 7, 131),
                  fontStyle: FontStyle.italic),
            ),
          ),
          ListTile(
            leading: Icon(Icons.food_bank_outlined, size: 45),
            title: Text(
              'Meal',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_outline, size: 45),
            title: Text(
              'Filter',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
