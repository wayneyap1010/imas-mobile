import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imas/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:imas/controller/clock_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  bool _isLoading = false;

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
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    // TODO: download the image and use local
                    image: new NetworkImage(
                        'https://images.unsplash.com/photo-1548032885-b5e38734688a?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80'))),
          ),
          ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                alignment: Alignment.center,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
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
                        hourMinuteDigitDecoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0),
                          ),
                        ),
                        amPmDigitTextStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        secondDigitDecoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 5.0),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: Text(
                          'Tan Yap Feng',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 5.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          minWidth: double.infinity,
                          height: 70.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(flex: 10),
                              Icon(
                                Icons.work,
                                size: 50.0,
                              ),
                              Spacer(flex: 1),
                              Text(
                                'Clock In',
                                style: TextStyle(fontSize: 25.0),
                              ),
                              Spacer(flex: 10),
                            ],
                          ),
                          color: Colors.teal.withOpacity(0.9),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            var status = await ClockController().clock('in');
                            setState(() {
                              status['success']
                                  ? _isLoading = false
                                  : _isLoading = false;
                            });
                            _alertBox(status['success'], status['msg']);
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 18.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          minWidth: double.infinity,
                          height: 70.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(flex: 10),
                              Icon(
                                Icons.work_off,
                                size: 50.0,
                              ),
                              Spacer(flex: 1),
                              Text(
                                'Clock Out',
                                style: TextStyle(fontSize: 25.0),
                              ),
                              Spacer(flex: 10),
                            ],
                          ),
                          color: Colors.red.withOpacity(0.9),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            var status = await ClockController().clock('out');
                            setState(() {
                              status['success']
                                  ? _isLoading = false
                                  : _isLoading = false;
                            });
                            _alertBox(status['success'], status['msg']);
                          },
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 18.0),
                      //   child: MaterialButton(
                      //     minWidth: double.infinity,
                      //     height: 70.0,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Spacer(flex: 10),
                      //         Icon(
                      //           Icons.work_off,
                      //           size: 50.0,
                      //         ),
                      //         Spacer(flex: 1),
                      //         Text(
                      //           'retrieve monthly history',
                      //           style: TextStyle(fontSize: 25.0),
                      //         ),
                      //         Spacer(flex: 10),
                      //       ],
                      //     ),
                      //     color: Colors.red,
                      //     onPressed: () async {
                      //       // var status = await Network().apiMonthlyHistory();
                      //       // print(status['data']);
                      //       // _monthlyHistory();
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  Card(
                    color: Colors.white.withOpacity(0.6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 5.0),
                          child: Text(
                            'Monthly History',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 26.0),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text('Date',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Time',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Clock',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('05-03-2020')),
                                DataCell(Text('09:00:00')),
                                DataCell(Text('in')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('05-03-2020')),
                                DataCell(Text('18:00:00')),
                                DataCell(Text('out')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('06-03-2020')),
                                DataCell(Text('08:57:00')),
                                DataCell(Text('in')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('06-03-2020')),
                                DataCell(Text('16:20:00')),
                                DataCell(Text('out')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('07-03-2020')),
                                DataCell(Text('08:54:20')),
                                DataCell(Text('in')),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
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
                  // Container(
                  //   width: double.infinity,
                  //   child: Card(
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: <Widget>[
                  //         Image(
                  //           image: AssetImage('images/quote_image.jpg'),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // _monthlyHistory(),
                ],
              ),
            ),
          ),
          _isLoading
              ? SpinKitDualRing(
                  color: Colors.white70,
                  size: 100.0,
                )
              : Stack(),
        ],
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = jsonDecode(res.body);
    print(body);
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

  _monthlyHistory() {
    return _monthlyHistoryData();
  }

  _monthlyHistoryData() async {
    var result = await Network().apiMonthlyHistory();
    // result['data'].forEach((element) {
    //   print(element);
    // });
    // return result['data'];

    Card data = Card(
      color: Colors.white.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 5.0),
            child: Text(
              'Monthly History',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text('Date',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Time',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Clock',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                result['data'].forEach((element) {
                  print(element);

                  DataRow(cells: [
                    DataCell(Text(element['mobile_date'])),
                    DataCell(Text(element['mobile_time'])),
                    DataCell(Text(element['clock'])),
                  ]);
                }),
              ],
            ),
          ),
        ],
      ),
    );

    return data;
  }
}
