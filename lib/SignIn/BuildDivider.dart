import 'package:flutter/material.dart';

class buildDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.black,
              height: 6,
            ),
          ),
        ],
      ),
    );
  }
}
