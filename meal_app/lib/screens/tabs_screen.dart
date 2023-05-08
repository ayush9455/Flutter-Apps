import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './drawerScreen.dart';
import './FavouritesScreen.dart';
import './categories_screen.dart';
import '../models/recipe.dart';

class TabsScreen extends StatefulWidget {
  @override
  late List<recipe> favMeals;
  TabsScreen(this.favMeals);
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> pages;
  int selectedIndex = 0;
  void _select_index(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      {'page': Categories_Screen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favMeals), 'title': 'Favourites'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pages[selectedIndex]['title'] as String),
        ),
        drawer: DrawerScreen(),
        body: pages[selectedIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: 'Favourites'),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          fixedColor: Colors.black,
          unselectedItemColor: Color.fromARGB(255, 208, 95, 121),
          onTap: _select_index,
          currentIndex: selectedIndex,
        ));
  }
}
