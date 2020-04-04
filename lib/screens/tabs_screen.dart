import 'package:flutter/material.dart';
import 'package:vamo_cozinhar/components/main_drawer.dart';
import 'package:vamo_cozinhar/models/meal.dart';
import 'package:vamo_cozinhar/screens/categories_screen.dart';
import 'package:vamo_cozinhar/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritesMeals;

  const TabsScreen(this.favoritesMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Lista de categorias',
        'screen': CategoriesScreen(),
      },
      {
        'title': 'Receitas favoritas',
        'screen': FavoriteScreen(widget.favoritesMeals)
      },
    ];
  }

  void _selectScreen(int value) {
    setState(() {
      _selectedScreenIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title']),
      ),
      body: _screens[_selectedScreenIndex]['screen'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categorias'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoritas'),
          ),
        ],
      ),
    );
  }
}
//class TabsScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    var tabBodies = <Widget>[CategoriesScreen(), FavoriteScreen()];
//    return DefaultTabController(
//      length: tabBodies.length,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('Vamos cozinhar?'),
//          bottom: TabBar(
//            tabs: <Widget>[
//              Tab(
//                icon: Icon(Icons.category),
//                text: 'Categorias',
//              ),
//              Tab(
//                icon: Icon(Icons.favorite),
//                text: 'Favoritos',
//              )
//            ],
//          ),
//        ),
//        body: TabBarView(
//          children: tabBodies,
//        ),
//      ),
//    );
//  }
//}
