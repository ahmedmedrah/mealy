import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/widgets/adaptive_raised_button.dart';
import 'package:mealy/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  Map<String, dynamic> _filters;
  static const String ROUTENAME = '/filters';
  Function setFilters;

  FiltersScreen(this._filters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget._filters['gluten'];
    _lactoseFree = widget._filters['lactose'];
    _vegan = widget._filters['vegan'];
    _vegetarian = widget._filters['vegetarian'];
  }

  Widget _buildSwitchTile(
      String title, String subTitle, bool val, Function updateVal) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subTitle),
      value: val,
      onChanged: updateVal,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildSwitchTile(
                  'Gluten-Free',
                  'only include gluten-free meals',
                  _glutenFree,
                  (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose-Free',
                  'only include lactose-free meals',
                  _lactoseFree,
                  (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegetarian',
                  'only include Vegetarian meals',
                  _vegetarian,
                  (val) {
                    setState(() {
                      _vegetarian = val;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'only include vegan meals',
                  _vegan,
                  (val) {
                    setState(() {
                      _vegan = val;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: AdaptiveRaisedButton(
              'Save',
              () {
                widget.setFilters({
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text('Filters'),
            ),
            body: _buildBody(),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Filters'),
            ),
            child: _buildBody(),
          );
  }
}
