import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imas/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:imas/controller/clock_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  var location;

  getLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((value) {
      setState(() {
        // print(value.toJson());
        location = value.toJson();
        print(location);
        // location = value.toString();
        // print(location.split(', '));
        // var lc = location.split(', ').toList();

        // print(lc[1]);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IMAS'),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitalClock(
                          digitAnimationStyle: Curves.elasticOut,
                          is24HourTimeFormat: false,
                          areaDecoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          hourMinuteDigitTextStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 50,
                          ),
                          amPmDigitTextStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50.0,
                          child: Text(
                            'Clock In',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            var status = await ClockController().clock('in');
                            _alertBox(status['success'], status['msg']);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50.0,
                          child: Text(
                            'Clock Out',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            var status = await ClockController().clock('out');
                            _alertBox(status['success'], status['msg']);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50.0,
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          color: Colors.redAccent,
                          onPressed: () {
                            logout();
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: MaterialButton(
                      //     minWidth: double.infinity,
                      //     height: 50.0,
                      //     child: Text(
                      //       'Location',
                      //       style: TextStyle(fontSize: 25.0),
                      //     ),
                      //     color: Colors.lightBlueAccent,
                      //     onPressed: () {
                      //       getLocation();
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     color: Colors.red,
                      //     width: double.infinity,
                      //     child: Column(children: <Widget>[
                      //       Container(
                      //         child: Text('Longitude'),
                      //       ),
                      //       Container(
                      //         child: Text(
                      //           'test',
                      //           // location['longitude'].toString(),
                      //           // style: TextStyle(fontSize: 30),
                      //         ),
                      //       ),
                      //     ]),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     color: Colors.red,
                      //     width: double.infinity,
                      //     child: Column(children: <Widget>[
                      //       Container(
                      //         child: Text('Latitude'),
                      //       ),
                      //       Container(
                      //         child: Text(
                      //           'test',
                      //           // location['latitude'].toString(),
                      //           // style: TextStyle(fontSize: 30),
                      //         ),
                      //       ),
                      //     ]),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(120.0),
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Column(children: [
                                Text('Date', style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('Time', style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('Clock', style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                            TableRow(children: [
                              Column(children: [Text('05-03-2020')]),
                              Column(children: [Text('09:00:00')]),
                              Column(children: [Text('in')]),
                            ]),
                            TableRow(children: [
                              Column(children: [Text('05-03-2020')]),
                              Column(children: [Text('18:00:00')]),
                              Column(children: [Text('out')]),
                            ]),
                            TableRow(children: [
                              Column(children: [Text('06-03-2020')]),
                              Column(children: [Text('08:57:00')]),
                              Column(children: [Text('in')]),
                            ]),
                            TableRow(children: [
                              Column(children: [Text('06-03-2020')]),
                              Column(children: [Text('16:20:00')]),
                              Column(children: [Text('out')]),
                            ]),
                            TableRow(children: [
                              Column(children: [Text('07-03-2020')]),
                              Column(children: [Text('08:54:20')]),
                              Column(children: [Text('in')]),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/quote_image.jpg'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = jsonDecode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  _alertBox(success, msg) {
    return Alert(
      context: context,
      type: success == true ? AlertType.success : AlertType.error,
      title: msg,
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
