import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/recipe.dart';
import './drawerScreen.dart';

class FilterScreen extends StatefulWidget {
  static String routeName = '/Filter-Screen';

  final Function saveFilter;
  final Map<String, bool> currfilter;

  FilterScreen(this.currfilter, this.saveFilter);
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currfilter['gluten'] as bool;
    _lactoseFree = widget.currfilter['lactose'] as bool;
    _vegan = widget.currfilter['vegan'] as bool;
    _vegetarian = widget.currfilter['vegetarian'] as bool;
    super.initState();
  }

  Widget buildSwitch(String Title, String Description, bool currvalue,
      Function(bool) updateVal) {
    return SwitchListTile(
      value: currvalue,
      onChanged: updateVal,
      title: Text(Title),
      subtitle: Text(Description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Screeen'),
        actions: [
          IconButton(
              onPressed: () {
                final Map<String, bool> _selectedfilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                final snack = SnackBar(content: Text("Changes Saved"));
                ScaffoldMessenger.of(context).showSnackBar(snack);
                widget.saveFilter(_selectedfilter);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: DrawerScreen(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.blueGrey[800]),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitch(
                    'Gluten Free', 'Displays Gluten Free Meals', _glutenFree,
                    (newvalue) {
                  setState(() {
                    _glutenFree = newvalue;
                  });
                }),
                buildSwitch(
                    'Lactose Free', 'Displays Lactose Free Meals', _lactoseFree,
                    (newvalue) {
                  setState(() {
                    _lactoseFree = newvalue;
                  });
                }),
                buildSwitch('Vegan', 'Dispaly Vegan Meals', _vegan, (newvalue) {
                  setState(() {
                    _vegan = newvalue;
                  });
                }),
                buildSwitch(
                    'Vegetarian', 'Display Vegetarian Meals', _vegetarian,
                    (newvalue) {
                  setState(() {
                    _vegetarian = newvalue;
                  });
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
