import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vamo_cozinhar/models/category.dart';
import 'package:vamo_cozinhar/utils/app_routes.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    final borderRadiusCategoryItem = BorderRadius.circular(15);
    return InkWell(
      onTap: () => _selectCategory(context),
      borderRadius: borderRadiusCategoryItem,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            category.color.withOpacity(.5),
            category.color,
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          borderRadius: borderRadiusCategoryItem,
        ),
        child: Text(category.title, style: Theme.of(context).textTheme.title),
      ),
    );
  }

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.CATEGORIES_MEALS,
      arguments: category,
    );
  }
}
