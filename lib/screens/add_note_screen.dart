import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/notes.dart';
import 'package:toast/toast.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  Builder buildDialogItem(
      BuildContext context, String text, IconData icon, ImageSource src) {
    return Builder(
      builder: (innerContext) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(text),
          onTap: () {
            context.read<Notes>().getImage(src);
            Navigator.of(innerContext).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    File _image = Provider.of<Notes>(context, listen: true).image;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(242, 237, 215, 1),
        title: Text(
          'Add note',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        actions: [
          Consumer<Notes>(
            builder: (ctx, value, _) => TextButton(
              child: Text(
                'Done',
                style: TextStyle(fontSize: 25, color: Colors.amber,fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                if (titleController.text.isEmpty) {
                  Toast.show("Please enter the Title", ctx,
                      duration: Toast.LENGTH_LONG);
                } else {
                  try {
                    value.add(
                      title: titleController.text,
                      description: descController.text,
                      category: "Education",
                    );
                    value.deleteImage();
                    Navigator.of(context).pop();
                    await Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => MyApp()));
                  } catch (e) {
                    Toast.show(e, ctx, duration: Toast.LENGTH_LONG);
                    print(e);
                  }
                }
              },
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Note Title", hintText: "Add Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Your Note", hintText: "Add note "),
              controller: descController,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(245, 167, 160, 1)),
                ),
                child: Text(
                  "Choose Image",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {
                  var ad = AlertDialog(
                    title: Text("Choose Picture from:"),
                    content: Container(
                      height: 150,
                      child: Column(
                        children: [
                          Divider(color: Colors.black),
                          buildDialogItem(context, "Camera",
                              Icons.add_a_photo_outlined, ImageSource.camera),
                          SizedBox(height: 10),
                          buildDialogItem(context, "Gallery",
                              Icons.image_outlined, ImageSource.gallery),
                        ],
                      ),
                    ),
                  );
                  showDialog(builder: (context) => ad, context: context);
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
