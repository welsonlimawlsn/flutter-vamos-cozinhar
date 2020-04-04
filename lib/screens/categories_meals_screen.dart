import 'package:flutter/material.dart';
import 'package:vamo_cozinhar/components/meal_item.dart';
import 'package:vamo_cozinhar/models/category.dart';
import 'package:vamo_cozinhar/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    final meals = this
        .meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(meals[index]);
          }),
    );
  }
}
