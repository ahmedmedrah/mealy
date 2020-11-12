import 'dart:io';

import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/models/meal_model.dart';

class MealDetailScreen extends StatelessWidget {
  static const String ROUTENAME = '/meal-detail';
  final isAndroid = Platform.isAndroid;
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

  Widget _buildListTiles(int index, Meal meal) {
    return isAndroid
        ? ListTile(
            leading: CircleAvatar(
              child: Text('# ${index + 1}'),
            ),
            title: Text(' ${meal.steps[index]}'),
          )
        : CupertinoListTile(
            leading: CircleAvatar(
              child: Text('# ${index + 1}'),
            ),
            title: Text(' ${meal.steps[index]}'),
          );
  }

  Widget _buildBody(BuildContext context, Meal meal) {
    return SafeArea(
      child: SingleChildScrollView(
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
                      _buildListTiles(index, meal),
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return isAndroid
        ? Scaffold(
            //Todo cupertino
            appBar: AppBar(title: Text(meal.title)),
            body: _buildBody(context, meal),
            floatingActionButton: FloatingActionButton(
              child:
                  Icon(_isFavorite(meal.id) ? Icons.star : Icons.star_border),
              onPressed: () async {
                await _addFavorite(meal.id);
              },
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(meal.title),
              trailing: GestureDetector(
                child: Icon(
                  _isFavorite(meal.id)
                      ? CupertinoIcons.star_fill
                      : CupertinoIcons.star,
                  size: 25,
                ),
                onTap: () async {
                  await _addFavorite(meal.id);
                },
              ),
            ),
            child: _buildBody(context, meal),
          );
  }
}
