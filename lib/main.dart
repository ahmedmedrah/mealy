import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:mealy/dummy_data.dart';
import 'package:mealy/models/meal_model.dart';
import 'package:mealy/screens/category_meals_screen.dart';
import 'package:mealy/screens/filters_screen.dart';
import 'package:mealy/screens/meal_detail.dart';
import 'package:mealy/screens/taps_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalStorage store = LocalStorage('mealy');
  Map<String, dynamic> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];


  _setLocalStorage(String name, Map data) async {
    await store.ready; // Make sure store is ready
    store.setItem(name, data);
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }



  void _initData() async {
    await store.ready;
    _filters = store.getItem('filters') ?? _filters;
  }


  _setFilters(Map<String, bool> filtersData){
    setState(() {
      _filters = filtersData;
      _setLocalStorage('filters', _filters);
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) return false;

        if (_filters['lactose'] == true && !meal.isLactoseFree) return false;

        if (_filters['vegan'] == true && !meal.isVegan) return false;

        if (_filters['vegetarian'] == true && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId){
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
        _setLocalStorage('favorites',
            {'favorites_ids': _favoritesMeals.map((e) => e.id).toList()});
      });
    } else {
      setState(() {
        _favoritesMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        _setLocalStorage('favorites',
            {'favorites_ids': _favoritesMeals.map((e) => e.id).toList()});
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    // _initData();
    return  MaterialApp(
      title: 'Mealy',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.yellow[50],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.grey[950]),
              bodyText2: TextStyle(color: Colors.grey[950]),
              button: TextStyle(color:Colors.white),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(_filters, _setFilters),
        CategoryMealsScreen.ROUTENAME: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.ROUTENAME: (ctx) =>
            MealDetailScreen(_toggleFavorites, _isMealFavorite),
        FiltersScreen.ROUTENAME: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
