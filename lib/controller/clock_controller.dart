import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imas/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class ClockController {
  bool _isLoading = false;
  final DateTime now = DateTime.now();

  void clock_in() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(now);
    String timeNow = DateFormat('kk:mm').format(now);

    // SpinKitRotatingCircle(
    //   color: Colors.white,
    //   size: 50.0,
    // );
    // TODO: get the name of the location
    // TODO: add spinkit while loading
    Position position = await getLocation();
    String encodedPosition = jsonEncode(position);
    Map<String, dynamic> arrData = jsonDecode(encodedPosition);
    arrData['mobile_date'] = dateNow;
    arrData['mobile_time'] = timeNow;

    print(jsonEncode(arrData));

    var res = await Network().apiClock(arrData, '/clockin');
    var body = jsonDecode(res.body);
    print(body);

    if (body['success']) {
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', jsonEncode(body['token']));
      // localStorage.setString('user', jsonEncode(body['user']));
    } else {
      // _showMsg(body['message']);
    }

    // setState(() {
    //   _isLoading = true;
    // });
    // var data = {
    //   'email': emailController.text,
    //   'password': passwordController.text
    // };
    //

    //
    // setState(() {
    //   _isLoading = false;
    // });
  }

  var location;

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    return position;
  }
}
