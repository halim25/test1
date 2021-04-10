import 'package:flutter/material.dart';


class CategoryCard extends StatelessWidget {
  final String id;
  final String title;
  final String addTime;
  final Color color;

  CategoryCard({
    @required this.id,
    @required this.title,
    @required this.addTime,
    @required this.color,
  });

  void selectCategory(BuildContext ctx) {


  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              addTime,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.4),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}