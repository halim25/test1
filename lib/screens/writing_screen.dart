import 'dart:ui';

import 'package:flutter/material.dart';

class WritingScreen extends StatefulWidget {
  final String initialText;

  WritingScreen({Key key, this.initialText}) : super(key: key);

  @override
  _WritingScreenState createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText??'');
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String description;
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(description);
            },
           child: Text("Done", style: TextStyle(
               fontSize: 25,
               color: Colors.amber,
               fontWeight: FontWeight.w500),),
          )
        ],
      ),
      body: TextField(
        controller: _controller,
        minLines: null,
        expands: true,
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            ),
        onChanged: (value) => description = value,
      ),
    );
  }
}
