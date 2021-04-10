import 'package:flutter/material.dart';

class ButtonWithIcon extends StatefulWidget {
  final String buttonText;
  final IconData icon;
  final Future<dynamic> Function() press;
  final ValueChanged<String> onChange;

  const ButtonWithIcon({
    @required this.buttonText,
    @required this.icon,
    @required this.press,
    @required this.onChange,
  });

  @override
  _ButtonWithIconState createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  String desc;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffe6776d),
      ),
      child: TextButton.icon(
        icon: Icon(
          widget.icon,
          color: Color(0xff3F2757),
          size: 30,
        ),
        label: Text(
          (desc==null||desc.isEmpty)?widget.buttonText:'Edit note ',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        onPressed: () async {

          desc=await widget.press();
          widget.onChange(desc);
          setState(() {
          });

        },
      ),
    );
  }
}
