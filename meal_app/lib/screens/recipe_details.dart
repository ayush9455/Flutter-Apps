import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../dummy-data.dart';

class recipe_details extends StatelessWidget {
  static String routeName = '/recipe-details';
  late MediaQueryData MQ;
  final Function isFav;
  final Function togglefav;
  recipe_details(this.isFav, this.togglefav);

  Widget buildcontainer(BuildContext context, Widget child) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(15),
          color: Colors.cyan[700]),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Widget buildtitle(BuildContext context, String Title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(Title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final mealid = routeArgs['id'];
    MQ = MediaQuery.of(context);
    final selectedmeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealid);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 239, 215),
      appBar: AppBar(title: Text(selectedmeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedmeal.imageUrl, fit: BoxFit.cover),
            ),
            buildtitle(context, 'Ingredients'),
            buildcontainer(
              context,
              ListView.builder(
                  itemBuilder: (ctx, idx) => Card(
                        color: Colors.amber[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(selectedmeal.ingredients[idx]),
                        ),
                      ),
                  itemCount: selectedmeal.ingredients.length),
            ),
            buildtitle(context, 'Steps'),
            buildcontainer(
              context,
              ListView.builder(
                  itemBuilder: (ctx, idx) => Card(
                      color: Colors.amber[200],
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('#${idx + 1}'),
                        ),
                        title: Text(selectedmeal.steps[idx]),
                      )),
                  itemCount: selectedmeal.steps.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFav(mealid) ? Icons.favorite_outlined : Icons.favorite_outline),
        onPressed: () => togglefav(mealid),
      ),
    );
  }
}
