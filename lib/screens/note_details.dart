

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes.dart';

class NoteDetails extends StatelessWidget {
  final String id;

  NoteDetails(this.id);

  @override
  Widget build(BuildContext context) {
    List<Note> prodList = Provider.of<Notes>(context, listen: true).notesList;

    var filteredItem =
        prodList.firstWhere((element) => element.id == id, orElse: () => null);

    return Scaffold(
      appBar:
          AppBar(title: filteredItem == null ? null : Text(filteredItem.title)),
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                SizedBox(height: 10),
                buildContainer(filteredItem.imagesFiles.isEmpty?null:filteredItem.imagesFiles[0], filteredItem.id),
                SizedBox(height: 10),
                buildCard(filteredItem.title, filteredItem.description,
                    filteredItem.addTime, context),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(
          Icons.delete,
        ),
      ),
    );
  }

  Container buildContainer(File image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child:image==null?Image.asset("assets/noteOpen.png"): Image.file(image),
        ),
      ),
    );
  }

  Card buildCard(
      String title, String desc, String addTime, BuildContext context) {
    return Card(
      elevation: 10,
      color: Color.fromRGBO(154, 125, 117, 1),
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            Text(desc??'', style: Theme.of(context).textTheme.bodyText1),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            Text(addTime,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
