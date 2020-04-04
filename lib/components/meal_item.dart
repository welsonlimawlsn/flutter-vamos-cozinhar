import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vamo_cozinhar/models/meal.dart';
import 'package:vamo_cozinhar/utils/app_routes.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _selectMeal(context),
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: FadeInImage.memoryNetwork(
                    image: meal.imageUrl,
                    placeholder: kTransparentImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    color: Colors.black54,
                    child: Text(
                      meal.title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MealProperty(
                    icon: Icons.schedule,
                    text: '${meal.duration.toString()} m',
                  ),
                  MealProperty(
                    icon: Icons.work,
                    text: meal.complexityText,
                  ),
                  MealProperty(
                    icon: Icons.attach_money,
                    text: meal.costText,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.all(10),
    );
  }

  void _selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.MEAL_DETAIL, arguments: meal)
        .then((result) => print(result));
  }
}

class MealProperty extends StatelessWidget {
  final IconData icon;
  final String text;

  const MealProperty({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 6,
        ),
        Text(text),
      ],
    );
  }
}
