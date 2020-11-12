import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealy/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String ROUTENAME = '/filters';
  Function setFilters;
  Map<String,dynamic> _filter;

  FiltersScreen(this._filter, this.setFilters);

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
    _glutenFree = widget._filter['gluten'];
    _lactoseFree = widget._filter['lactose'];
    _vegan = widget._filter['vegan'];
    _vegetarian = widget._filter['vegetarian'];

  }

  Widget _buildSwitchTile(
      String title, String subTitle, bool val, Function updateVal) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        value: val,
        onChanged: updateVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
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
            child: RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                widget.setFilters({
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                });
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save),
              label: Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
