import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:imas/controller/controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    super.initState();
    // authenticationController().insertApi();
    // authenticationController().checkSKey(context);
  }

  bool _rememberMe = true;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.white70,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  Widget loginLegendText(text) {
    return Container(
      width: 600.0,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Opensans',
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget loginUsernameTF() {
    return Container(
      width: 600.0,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextField(
        controller: userNameController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 16.0),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black87,
          ),
          hintText: 'Enter your username',
        ),
      ),
    );
  }

  Widget loginPasswordTF() {
    return Container(
      width: 600.0,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 16.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black87,
          ),
          hintText: 'Enter your password',
        ),
      ),
    );
  }

  Widget rememberMeCB() {
    return Container(
      width: 600.0,
      height: 50.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Opensans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginBT() {
    return Builder(
        builder: (context) => Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: 600.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    Controller().login(
                      context,
                      userNameController.text,
                      passwordController.text,
                    );
                    // authenticationController().login(
                    //   context,
                    //   userNameController.text,
                    //   passwordController.text,
                    // );
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.red,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        backgroundColor: Colors.red,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.white],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      // logo(),
                      SizedBox(height: 50.0),
                      loginLegendText('Username'),
                      SizedBox(height: 10.0),
                      loginUsernameTF(),
                      SizedBox(height: 30.0),
                      loginLegendText('Password'),
                      SizedBox(height: 10.0),
                      loginPasswordTF(),
                      SizedBox(height: 5.0),
                      // rememberMeCB(),
                      loginBT(),
                      Text(
                        'IMAS V1.0',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
