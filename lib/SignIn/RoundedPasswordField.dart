import 'package:flutter/material.dart';
import 'package:nepal_bank/SignIn/TextFieldContainer.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          border: InputBorder.none,
          icon: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: Colors.deepPurple,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
