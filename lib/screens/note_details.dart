

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

    var filteredItem = prodList.firstWhere((element) => element.id == id, orElse: () => null);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: filteredItem == null ? null : Text(filteredItem.title)),
      body: filteredItem == null
          ? null
          : ListView(
        children: [
          SizedBox(height: 10),
          buildContainer(filteredItem.image, filteredItem.id),
          SizedBox(height: 10),
          buildCard(filteredItem.title, filteredItem.description,
              filteredItem.addTime),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),
    );
  }

  Container buildContainer(File image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.file(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc,String addTime) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Text(desc,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            Divider(color: Colors.black),
            Text(
              "${addTime.hashCode}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
