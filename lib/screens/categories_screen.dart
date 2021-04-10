import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/category_card.dart';
import '../providers/note_category.dart';
import 'add_note_screen.dart';
import '../providers/notes.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categoriesList = Provider.of<Categories>(context, listen: true).categoriesList;



    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: categoriesList.isEmpty
          ? Center(
          child: Text('No Notes Added.', style: TextStyle(fontSize: 22)))
          : GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          maxCrossAxisExtent: 500,
          childAspectRatio: 1.5,
        ),
        children:categoriesList
            .map(
              (item) => Builder(
              builder: (ctx) => CategoryCard(
                id: item.id,
                title: item.title,
                addTime: item.addTime,
                color: item.color,
              )),
        )
            .toList(),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => AddNote())),
      child: Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}
