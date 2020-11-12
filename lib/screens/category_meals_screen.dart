import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/dummy_data.dart';
import 'package:mealy/models/meal_model.dart';
import 'package:mealy/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const ROUTENAME = '/category-meals';
  final List<Meal> _availableMeals ;

  CategoryMealsScreen(this._availableMeals);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = _availableMeals
        .where((element) => element.categories.contains(categoryId))
        .toList();
    return Platform.isAndroid ? Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(categoryMeals[index]);
          }),
    ) : CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(categoryTitle),
      ),
      child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(categoryMeals[index]);
          }),
    );
  }
}
