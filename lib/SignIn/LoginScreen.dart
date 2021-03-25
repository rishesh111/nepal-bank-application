import 'package:flutter/material.dart';
import 'package:nepal_bank/SignIn/Body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen.
    return Scaffold(
      body: Body(),
    );
  }
}
