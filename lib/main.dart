import 'package:flutter/material.dart';
import 'package:vamo_cozinhar/data/dummy_data.dart';
import 'package:vamo_cozinhar/models/meal.dart';
import 'package:vamo_cozinhar/models/settings.dart';
import 'package:vamo_cozinhar/screens/categories_meals_screen.dart';
import 'package:vamo_cozinhar/screens/meal_detail_screen.dart';
import 'package:vamo_cozinhar/screens/settings_screen.dart';
import 'package:vamo_cozinhar/screens/tabs_screen.dart';
import 'package:vamo_cozinhar/utils/app_routes.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeal(Settings settings) {
    setState(() {
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  bool _toggleFavorite(Meal meal) {
    bool removed = false;
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
        removed = true;
      } else {
        _favoriteMeals.add(meal);
        removed = false;
      }
    });
    return !removed;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.amber,
          fontFamily: 'Raleway',
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  color: Colors.white))),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(_toggleFavorite),
        AppRoutes.SETTING: (ctx) =>
            SettingsScreen(onChangeSettings: _filterMeal),
      },
    );
  }
}
