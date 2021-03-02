import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:imas/controller/controller.dart';
import 'package:imas/network_utils/api.dart';
import 'package:imas/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void initState() {
    super.initState();
    // authenticationController().insertApi();
    // authenticationController().checkSKey(context);
  }

  bool _rememberMe = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
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

  Widget loginEmailTF() {
    return Container(
      width: 600.0,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextField(
        controller: emailController,
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
          hintText: 'Enter your email',
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
                    _login();
                    // Controller().login(
                    //   context,
                    //   emailController.text,
                    //   passwordController.text,
                    // );
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
    return Scaffold(
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
                    Text(
                      'IMAS',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                    // logo(),
                    SizedBox(height: 60.0),
                    loginLegendText('Email'),
                    SizedBox(height: 10.0),
                    loginEmailTF(),
                    SizedBox(height: 30.0),
                    loginLegendText('Password'),
                    SizedBox(height: 10.0),
                    loginPasswordTF(),
                    SizedBox(height: 5.0),
                    // rememberMeCB(),
                    loginBT(),
                    Text(
                      'IMAS V1.0.1',
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
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': emailController.text,
      'password': passwordController.text
    };

    var res = await Network().authData(data, '/login');
    var body = jsonDecode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', jsonEncode(body['token']));
      localStorage.setString('user', jsonEncode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
