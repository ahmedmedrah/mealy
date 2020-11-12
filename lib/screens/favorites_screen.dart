import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mealy/models/meal_model.dart';
import 'package:mealy/widgets/meal_item.dart';

import '../dummy_data.dart';

class FavoritesScreen extends StatefulWidget {


  // FavoritesScreen(this._favoritesMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Meal> _favoritesMeals = [];
  final LocalStorage store = LocalStorage('mealy');

  Future<List<Meal>> _getFavorites() async{
    await store.ready;

    List<dynamic> favs_ids = [];
    if (store.getItem('favorites') != null) {
      favs_ids = store
          .getItem('favorites')['favorites_ids']
          .map((e) => e.toString())
          .toList();
    }
    return DUMMY_MEALS.where((e) => favs_ids.any((id) => id == e.id)).toList() ?? [];
  }
  @override
  void didChangeDependencies() {
    _getFavorites().then((value) {
      setState(() {
        _favoritesMeals = value;
      });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    print('favs ' + _favoritesMeals.toString());
    return _favoritesMeals.isEmpty
        ? Center(
            child: Text('You have no favorites yet!'),
          )
        : ListView.builder(
            itemCount: _favoritesMeals.length,
            itemBuilder: (ctx, index) {
              return MealItem(_favoritesMeals[index]);
            },
          );
  }
}
