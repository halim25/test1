import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final String description;
  final DateTime addTime;
  final Color color;

  Category({
    @required this.id,
    @required this.title,
    @required this.addTime,
    @required this.color,
    this.description,
  });
}
class Categories with ChangeNotifier {
  List<Category> categoriesList = [];


  void add({String title, String description,Color color,}) {
    categoriesList.add(Category(
        id: 1,
        title: title,
        description: description,
        addTime: DateTime.now(),
        color:color ,));
    notifyListeners();
  }

  void delete(String description) {
    categoriesList.removeWhere((element) => element.description == description);
    notifyListeners();
  }

}

