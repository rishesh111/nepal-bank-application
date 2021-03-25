import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_bank/HomePage/HomePage.dart';
import 'package:nepal_bank/SignIn/AlreadyHaveAnAccountCheck.dart';
import 'package:nepal_bank/SignIn/Background.dart';
import 'package:nepal_bank/SignIn/BuildDivider.dart';
import 'package:nepal_bank/SignIn/LoginModel.dart';
import 'package:nepal_bank/SignIn/TextFieldContainer.dart';
import 'package:nepal_bank/SignUp/SignUp.dart';
import 'package:nepal_bank/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        content: Text("Email or password is incorrect"),
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
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<Login> loginuser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String apiUrl =
        '${Constants.baseUrl}api/login'; //remember the ip address of wifi. use prefered
    Map data = {
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
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }else{
      await createAlertDialog(context);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.grey[700],
                ),
              ),
              buildDivider(),
              TextFieldContainer(
                child: TextFormField(
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
                  keyboardType:  TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  controller: emailController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.contact_mail,
                      color: Colors.deepPurple,
                    ),
                    hintText: 'Your Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              /* RoundedInputField(
                controller: emailController,
                hintText: 'Your Email',
                onChanged: (value) {},
                icon: Icons.contact_mail,
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),*/
              TextFieldContainer(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  validator: (val)=> val.isEmpty? "Password is required!":null,
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300],
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    ),
                    /*onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },*/
                    onPressed: _isLoading ? null : () async {
                      if(_formKey.currentState.validate()){
                        setState(() {
                          _isLoading = true;
                        });
                        final String email = emailController.text;
                        final String password = passwordController.text;
                        Login login = await loginuser(email, password);
                      }
                    },
                    child: Text(
                      _isLoading ? "Logging...":"Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              /*RoundedButton(
                text: "Login",
                press: () async {
                  final String email = emailController.text;
                  final String password = passwordController.text;
                  Login login = await loginuser(email, password);
                  setState(() {
                    _isLoading = true;
                  });
                },
                Backcolor: Colors.deepPurple[300],
                textColor: Colors.white,
              ),*/
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
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
