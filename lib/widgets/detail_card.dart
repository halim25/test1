import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';
import '../screens/note_details.dart';

class DetailCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String addTime;
  final File image;

  const DetailCard({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.addTime,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteDetails(id)),
        ).then((id) => Provider.of<Notes>(context, listen: false).delete(id));
      },
      child: Wrap(
        children: [
          SizedBox(height: 5),
          Card(
            elevation: 10,
            color: Color.fromRGBO(154, 125, 117, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      width: 130,
                      child: Hero(
                        tag: id,
                        child: image == null
                            ? Image.asset('assets/note.png', fit: BoxFit.cover)
                            : Image.file(image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                            color: Color.fromRGBO(63, 39, 87, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        color: Colors.white,
                        height: 10,
                        thickness: 3,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          description,
                          style:
                              TextStyle(color: Color(0xffFEE2A3), fontSize: 18),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 10,
                        thickness: 3,
                      ),
                      Text(
                        addTime,
                        style:
                            TextStyle(color: Color(0xffFEE2A3), fontSize: 18),
                      ),
                      SizedBox(height: 13),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
