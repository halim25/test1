import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'writing_screen.dart';
import '../widgets/button_with_icon.dart';
import '../widgets/multi_select_images.dart';
import '../providers/notes.dart';
import 'package:toast/toast.dart';

class AddNote extends StatelessWidget {
  List<File> imagesFiles=[];

  void getImages(List<File> images){
      imagesFiles=images;
  }

  String title = '';
  String description;

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
        title: Text('Add note'),
        actions: [
          Consumer<Notes>(
            builder: (ctx, value, _) => TextButton(
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.amber,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                if (title == '') {
                  Toast.show("Please enter the Title", ctx,
                      duration: Toast.LENGTH_LONG);
                } else {
                  try {
                    value.add(
                      title: title,
                      description: description,
                      imagesFiles: imagesFiles,
                      category: "Education",
                    );
                    value.deleteImage();
                    Navigator.of(context).pop();
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
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              buildTextField(),
              SizedBox(height: 10),
              ButtonWithIcon (buttonText: 'Add note',icon: Icons.post_add,press:()async{
                return  Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => WritingScreen(initialText: description,)));
              },onChange: (value){description=value;},),
              SizedBox(height: 10),
              MultiSelectImages(function:getImages),
              SizedBox(height: 30),
              //buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtonWithIcon({BuildContext ctx,String buttonText,IconData icon,Function press}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:Color(0xffe6776d),
      ),
      child:TextButton.icon(
        icon:  Icon(icon, color:Color(0xff3F2757),size: 30,),
        label: Text(
          buttonText,
          style: Theme.of(ctx).textTheme.subtitle2,
        ),
        onPressed:press,
      ),
    );
  }

  Container buildButton(BuildContext ctx,) {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:Color(0xffe6776d),
              ),
              child:TextButton.icon(
                icon:  Icon(Icons.add_photo_alternate_outlined, color:Color(0xff3F2757),size: 30,),
                label: Text(
                  "Choose Image",
                  style: Theme.of(ctx).textTheme.subtitle2,
                ),
                onPressed:()=>buildShowDialog( ctx),
              ),
            );
  }

   buildShowDialog( BuildContext ctx)  {
     var ad = AlertDialog(
       title: Text("Choose Picture from:"),
       content: Container(
         height: 150,
         child: Column(
           children: [
             Divider(color: Colors.black),
             buildDialogItem(ctx, "Camera",
                 Icons.add_a_photo_outlined, ImageSource.camera),
             SizedBox(height: 10),
             buildDialogItem(ctx, "Gallery",
                 Icons.image_outlined, ImageSource.gallery),
           ],
         ),
       ),
     );
    showDialog(builder: (ctx) => ad, context: ctx);
  }

  TextField buildTextField() {
    return TextField(
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "  Add Title",
                prefixIcon: Icon(
                  Icons.drive_file_rename_outline,
                  color: Colors.black,
                  size: 30,
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) => title = value,
            );
  }
}
