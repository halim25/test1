import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final String category;
  final String addTime;
  final List<File> imagesFiles;
  final File record;


  Note({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.category,
    @required this.addTime,
    @required this.imagesFiles,
    @required this.record,
  });
}

class Notes with ChangeNotifier {
  List<Note> notesList = [];
  File image ;
  File record;



  void add({String title, String description,String category,List<File> imagesFiles}) {
    notesList.add(Note(
        id: '${DateTime.now().hashCode}',
        title: title,
        description: description,
        category: category,
        addTime:"${DateFormat.yMMMMd().format(DateTime.now())}\n ${DateFormat.E().add_jm().format(DateTime.now())}" ,
        record: record,
        imagesFiles: imagesFiles));
    notifyListeners();
  }

  void delete(String id) {
    notesList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void deleteImage() {
    image = null;
  }

  Future getImage(ImageSource src) async {
    final pickedFile = await ImagePicker().getImage(source: src);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
      print('Image selected.');
    } else {
      print('No image selected.');
    }
  }
}
