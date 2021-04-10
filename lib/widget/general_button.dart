import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color textColor;
  final double sizeFont;

  const GeneralButton({
    @required this.buttonName,
    @required this.buttonColor,
    @required this.textColor,
    @required this.sizeFont});


  @override
  Widget build(BuildContext context) {

    return Container(

      //padding: EdgeInsets.only(left: size / 2, right: size / 2),
      width: 350,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            buttonName,
            textScaleFactor: 1,
            style: TextStyle(
              color: textColor,
              fontSize: sizeFont,
              // fontWeight: FontWeight.w500,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),

          ),

        ),
      ),
    );
  }
}
