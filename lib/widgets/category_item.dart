import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.ROUTENAME,
        arguments: {'id': id, 'title': title});
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topRight,
            end: AlignmentDirectional.bottomEnd,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? InkWell(
            onTap: () => selectCategory(context),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            child: _buildItem(context),
          )
        : GestureDetector(
            onTap: () => selectCategory(context),
            child: _buildItem(context),
          );
  }
}
