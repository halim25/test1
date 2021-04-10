import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/detail_card.dart';
import 'add_note_screen.dart';
import '../providers/notes.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Note> noteList = Provider.of<Notes>(context, listen: true).notesList;


    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: noteList.isEmpty
          ? Center(
              child: Text('No Notes Added.', style: TextStyle(fontSize: 22, color: Colors.black)))
          : GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                maxCrossAxisExtent: 500,
                childAspectRatio: 1.5,
              ),
              children: noteList
                  .map(
                    (item) => Builder(
                        builder: (ctx) => DetailCard(
                              id: item.id,
                              title: item.title??'',
                              description: item.description??'',
                              image: item.imagesFiles.isEmpty?null:item.imagesFiles[0],
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
