import 'package:flutter/material.dart';
import 'package:mealy/screens/categories_screen.dart';
import 'package:mealy/screens/category_meals_screen.dart';
import 'package:mealy/screens/meal_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mealy',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.yellow[50],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.grey[950]),
              bodyText2: TextStyle(color: Colors.grey[950]),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      routes: {
        '/': (ctx) => CategoriesScreen(),
        CategoryMealsScreen.ROUTENAME: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.ROUTENAME: (ctx) => MealDetailScreen(),
      },
    );
  }
}
