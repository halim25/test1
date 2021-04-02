import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/detail_card.dart';
import 'add_note_screen.dart';
import '../providers/notes.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Note> noteList = Provider.of<Notes>(context, listen: true).notesList;

    Widget buildText(title, desc, category) {
      var description =
          desc.length >= 15 ? desc.replaceRange(15, desc.length, '...') : desc;
      return Positioned(
        bottom: 10,
        right: 10,
        child: Container(
          width: 180,
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            "$title\n$description\n$category",
            style: TextStyle(fontSize: 26, color: Colors.white),
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 4,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: noteList.isEmpty
          ? Center(
              child: Text('No Notes Added.', style: TextStyle(fontSize: 22)))
          : ListView(
              children: noteList
                  .map(
                    (item) => Builder(
                        builder: (ctx) => DetailCard(
                              id: item.id,
                              title: item.title,
                              description: item.description,
                              image: item.image,
                              addTime: item.addTime,
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
