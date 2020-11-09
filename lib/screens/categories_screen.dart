import 'package:flutter/material.dart';
import 'package:mealy/dummy_data.dart';
import 'package:mealy/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Todo cupertino
      appBar: AppBar(
        title: const Text('Mealy'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map((cateData) => CategoryItem(cateData.id,cateData.title, cateData.color))
            .toList(),
      ),
    );
  }
}
