import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://192.168.1.108/imas/public/api/v1';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();

    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  apiClock(data, apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    data['email'] = jsonDecode(localStorage.getString('user'))['email'];

    var fullUrl = _url + apiUrl;
    // print(fullUrl);
    final http.Response response = await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
    // print(response);

    return response;
    // return await http.post(fullUrl,
    //     body: jsonEncode(data), headers: _setHeaders());
  }
}
