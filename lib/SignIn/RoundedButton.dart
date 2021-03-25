import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color Backcolor, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.Backcolor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.65,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Backcolor,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
