import 'package:flutter/material.dart';
import 'package:mealy/models/meal_model.dart';
import 'package:mealy/screens/categories_screen.dart';
import 'package:mealy/screens/favorites_screen.dart';
import 'package:mealy/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String,dynamic>> _pages;
  int _selectedPageIndex = 0;
  List<Meal> _favoritesMeals;



  @override
  void initState() {
    super.initState();
    _pages = [
      { 'page': CategoriesScreen(),
        'title': 'Categories',
      },
      { 'page': FavoritesScreen(),
        'title': 'Favorites',
      },
    ];
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    //TODO Cupertino
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,  if type == shifting
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,  if type == shifting
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      drawer: MainDrawer()
    );
  }
}
