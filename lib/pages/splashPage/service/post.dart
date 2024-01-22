// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class RemoteServicesSplash {
  Future getAds(url) async {
    final _localStorage = Hive.box('localStorage');
    var client = http.Client();

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      _localStorage.put('ads', json);
      return true;
    } else {
      return null;
    }
  }

  Future getUserStatus() async {
    final _localStorage = Hive.box('localStorage');
    String url = 'https://mercadopoupanca.azurewebsites.net/';
    var headers;

    if (_localStorage.get('token') != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_localStorage.get('token')}'
      };
      url = 'https://mercadopoupanca.azurewebsites.net/?type=withUser';
    } else {
      headers = {'Content-Type': 'application/json'};
    }

    var request = http.Request('GET', Uri.parse(url));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      _localStorage.put('token', null);
      return 'Logout';
    } else {
      _localStorage.put('token', null);
      return false;
    }
  }
}
