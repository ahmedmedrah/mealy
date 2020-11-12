import 'package:flutter/material.dart';
import 'package:mealy/models/meal_model.dart';

class MealDetailScreen extends StatelessWidget {
  static const String ROUTENAME = '/meal-detail';
  Function _addFavorite;
  Function _isFavorite;

  MealDetailScreen(this._addFavorite, this._isFavorite);

  Widget buildSectionTitle(String title, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, Widget child) {
    return Container(
        width: 300,
        height: 150,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      //Todo cupertino
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
              context,
              ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(meal.ingredients[index]),
                      ),
                    );
                  }),
            ),
            buildSectionTitle('Steps', context),
            buildContainer(
              context,
              ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) {
                    return Column(children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(' ${meal.steps[index]}'),
                      ),
                      Divider(
                        thickness: 3,
                      )
                    ]);
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isFavorite(meal.id) ? Icons.star : Icons.star_border),
        onPressed: () async {
          await _addFavorite(meal.id);
        },
      ),
    );
  }
}
