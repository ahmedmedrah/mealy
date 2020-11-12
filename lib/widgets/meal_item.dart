import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/models/meal_model.dart';
import 'package:mealy/screens/meal_detail.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem(this.meal);

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Intermediate:
        return 'Intermediate';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  void selectMeal(ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.ROUTENAME, arguments: meal);
  }

  Widget buildCard(double elevation) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: elevation,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black45,
                  ),
                  child: Text(
                    meal.title,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${meal.duration} min'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.work),
                    SizedBox(
                      width: 6,
                    ),
                    Text('$complexityText'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.money),
                    SizedBox(
                      width: 6,
                    ),
                    Text('$affordabilityText'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? InkWell(
      onTap: () => selectMeal(context),
      child: buildCard(4),
    ) : GestureDetector(
      onTap: () => selectMeal(context),
      child: buildCard(1),
    );
  }
}
