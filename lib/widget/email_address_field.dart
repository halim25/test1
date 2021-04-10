import 'package:flutter/material.dart';
class EmailAddressFiled extends StatelessWidget {

  // ignore: non_constant_identifier_names
  final Color IconColor;
  // ignore: non_constant_identifier_names
  final Color HintTextColor;
  final ValueChanged<String> onChanged;

  // ignore: non_constant_identifier_names
  const EmailAddressFiled({Key key, this.IconColor, this.HintTextColor, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width-350;
    return Container(
      padding: EdgeInsets.only(left: size/2,right: size/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              "Email Address ",
              textScaleFactor: 1,
              style: TextStyle(
                color: HintTextColor,
                fontSize: 20,
                fontWeight: FontWeight.w400 ,
              ),
            ),
          ),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: IconColor,
              ),
              hintText: "Email Address",
              hintStyle: TextStyle(
                  color: HintTextColor,
                  fontSize: 18,
                fontWeight: FontWeight.w300,),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            keyboardType:TextInputType.emailAddress ,
          ),
        ],
      ),
    );
  }
}


