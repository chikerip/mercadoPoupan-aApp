import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/accountPage/models/post.dart';

class RemoteServicesAccount{
  Future<List<Post>?> getPosts(url, token)async{
    var headers = {
      // ignore: unnecessary_brace_in_string_interps
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('http://192.168.137.1:8080/user?type=userInfo'));
    request.body = '''''';
    request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        return postFromJson(json);
      } else {
        return null;
      }
  }
}