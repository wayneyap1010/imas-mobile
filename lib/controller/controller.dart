import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imas/screen/home_screen.dart';

class Controller {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  static String apiUrl = 'http://imas.windtertech.com.my/apps/api';
  static String email = 'test@windtertech.com';
  static String password = 'test1234';

  login(context, String username, String password) async {
    String request = 'login';
    var loginData;

    // //**********base64 username and password encode
    // String encodedEmail = stringToBase64.encode(email);
    // String encodedPassword = stringToBase64.encode(password);
    // String encodedEmailPassword =
    //     stringToBase64.encode("$encodedEmail@$encodedPassword");
    //
    // var url = '$apiUrl?req=$request&value=$encodedEmailPassword';
    //
    // // Await the http get response, then decode the json-formatted response.
    // var response = await http.get(url);
    //
    // if (response.statusCode == 200) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()),
    //   );
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
