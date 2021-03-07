import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:imas/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class ClockController {
  final DateTime now = DateTime.now();

  clock(status) async {
    String dateNow = DateFormat('yyyy-MM-dd').format(now);
    String timeNow = DateFormat('kk:mm:ss').format(now);

    Position position = await getLocation();
    String encodedPosition = jsonEncode(position);
    Map<String, dynamic> arrData = jsonDecode(encodedPosition);

    Placemark placemark =
        await getLocationName(arrData['latitude'], arrData['longitude']);

    arrData['clock_status'] = status;
    arrData['mobile_date'] = dateNow;
    arrData['mobile_time'] = timeNow;
    arrData['house_no'] = placemark.name;
    arrData['street'] = placemark.street;
    arrData['country'] = placemark.country;
    arrData['postal_code'] = placemark.postalCode;
    arrData['state'] = placemark.administrativeArea;
    arrData['city'] = placemark.locality;
    arrData['area'] = placemark.subLocality;
    arrData['street_name'] = placemark.thoroughfare;

    var res = await Network().apiClock(arrData, '/clock');
    var body = jsonDecode(res.body);
    // print(body);

    return body;
  }

  var location;

  Future<Position> getLocation() async {
    // get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    return position;
  }

  Future<dynamic> getLocationName(latitude, longitude) async {
    // using coordinates to retrieve location name
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placeMark = placemarks[0];

    return placeMark;
  }
}
