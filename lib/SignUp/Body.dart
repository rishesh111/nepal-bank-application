import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nepal_bank/SignIn/AlreadyHaveAnAccountCheck.dart';
import 'package:nepal_bank/SignIn/Background.dart';
import 'package:nepal_bank/SignIn/BuildDivider.dart';
import 'package:nepal_bank/SignIn/LoginScreen.dart';
import 'package:nepal_bank/SignIn/RoundedButton.dart';
import 'package:nepal_bank/SignIn/TextFieldContainer.dart';
import 'package:nepal_bank/SignUp/SignUpModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<void> createAlertDialog(BuildContext context) async{
    return await showDialog(context: context,builder: (context){
      return AlertDialog(
        title:
        Text("Error!!", textAlign: TextAlign.center,style:TextStyle(color: Colors.red),),
        content: Text("Email is already used."),
        actions: <Widget>[
          TextButton(
            child:Text('Okay',style: TextStyle(color: Colors.black),),
            onPressed: (){
              Navigator.of(context).pop();
              setState(() {
                _isLoading = false;
              });
            },
          )
        ],
      );
    });
  }

  bool _isLoading = false;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<SignUp> SignInUser(String name, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String apiUrl =
        '${Constants.baseUrl}api/register'; //remember the ip address of wifi. use prefered
    Map data = {
      'name' : name,
      'email': email,
      'password': password,
    };

    var responseString = null;
    var response = await http.post(apiUrl, body: data);

    if (response.statusCode == 200) {
      responseString = json.decode(response.body);
      if (responseString != null) {
        setState(() {
          _isLoading = true;
        });
        sharedPreferences.setString("token", responseString['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                (Route<dynamic> route) => false);
      }
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
    else if(response.statusCode == 400){
      await createAlertDialog(context);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.grey[700],
                ),
              ),
              buildDivider(),
              TextFieldContainer(
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: nameController,
                  validator: (val)=> val.isEmpty? "Name is required!":null,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: emailController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email address is required!';
                    }
                    if (!RegExp(
                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Please Enter a valid Email address.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.contact_mail,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: passwordController,
                  validator: (val)=> val.isEmpty? "Password is required!":null,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              RoundedButton(
                text: _isLoading ? 'Registering...' :  "Register",
                press: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      _isLoading = true;
                    });
                    final String name = nameController.text;
                    final String email = emailController.text;
                    final String password = passwordController.text;
                    SignUp register = await SignInUser(name, email, password);
                  }
                },
                Backcolor: Colors.deepPurple[300],
                textColor: Colors.white,
              ),
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    }

}
