import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Color IconColor;

  // ignore: non_constant_identifier_names
  final Color HintTextColor;
  final ValueChanged<String> onChanged;

  // ignore: non_constant_identifier_names
  const PasswordField(
      {Key key, this.IconColor, this.HintTextColor, this.onChanged})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width-350;
    return Container(
      padding: EdgeInsets.only(left: size/2,right: size/2),

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "  Password ",
                textScaleFactor: 1,
                style: TextStyle(
                  color: widget.HintTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot password?",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: widget.IconColor,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: widget.IconColor,
                ),
                color: widget.IconColor,
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                color: widget.HintTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              alignLabelWithHint: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
            obscureText: _hidePassword,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
