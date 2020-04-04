import 'package:flutter/material.dart';
import 'package:vamo_cozinhar/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final bool Function(Meal) onToggle;

  MealDetailScreen(this.onToggle);

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: <Widget>[
          FavoriteIcon(
            meal: meal,
            onPressed: () {
              return onToggle(meal);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3 * 1,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitleSection(context, 'Ingredientes'),
            buildBodySection(
                context,
                ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: meal.ingredients.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(meal.ingredients[index]),
                        ),
                        color: Theme.of(context).accentColor,
                      );
                    })),
            buildTitleSection(context, 'Passo a passo'),
            buildBodySection(
              context,
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    if (index < meal.steps.length - 1) Divider()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodySection(BuildContext context, ListView listView) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height / 4 * 1,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: listView,
    );
  }

  Widget buildTitleSection(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .title
            .merge(TextStyle(color: Colors.black)),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final bool Function() onPressed;
  final Meal meal;

  FavoriteIcon({this.onPressed, this.meal});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      onPressed: () {
        if (onPressed()) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Adicionado aos favoritos'),
          ));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Removido dos favoritos'),
          ));
        }
//        Navigator.of(context).pop(meal.title);
      },
      tooltip: 'Adicionar receita as minhas favoritas',
    );
  }
}
