
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Category {
  final String id;
  final String title;
  final String addTime;
  final Color color;

  Category({
    @required this.id,
    @required this.title,
    @required this.addTime,
    @required this.color,

  });
}
class Categories with ChangeNotifier {
  List<Category> categoriesList = [];


  void add({String title, String description,Color color,}) {
    categoriesList.add(Category(
        id:'${DateTime.now().hashCode}',
        title: title,
        addTime:"${DateFormat.yMMMMd().format(DateTime.now())}\n ${DateFormat.E().add_jm().format(DateTime.now())}" ,
        color:color ,));
    notifyListeners();
  }

  void delete(String id) {
    categoriesList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

}

