import 'package:flutter/material.dart';
import 'package:vamo_cozinhar/components/meal_item.dart';
import 'package:vamo_cozinhar/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoritesMeals;

  FavoriteScreen(this.favoritesMeals);

  @override
  Widget build(BuildContext context) {
    if (favoritesMeals.isEmpty) {
      return Center(
        child: Text('Nenhuma receita foi marcada como favorita!'),
      );
    }

    return ListView.builder(
        itemCount: favoritesMeals.length,
        itemBuilder: (ctx, index) {
      return MealItem(favoritesMeals[index]);
    });
  }
}
