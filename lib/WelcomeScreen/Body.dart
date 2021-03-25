import 'package:flutter/material.dart';
import 'package:nepal_bank/SignIn/LoginScreen.dart';
import 'package:nepal_bank/SignUp/SignUp.dart';
import 'package:nepal_bank/WelcomeScreen/Background.dart';
import 'package:nepal_bank/WelcomeScreen/RoundedButton.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen.
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome To Nepal Bank',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              'Images/nepal-bank.png',
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: 'Sign In',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              Backcolor: Colors.deepPurple[200],
              textColor: Colors.white,
            ),
            RoundedButton(
              text: 'Sign Up',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              textColor: Colors.black,
              Backcolor: Colors.deepPurple[100],
            ),
          ],
        ),
      ),
    );
  }
}
