import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/catalogPage/models/post.dart';

class RemoteServicesCatalog{
  Future<List<Post>?> getPosts(url, bodyRequest)async{
    if(bodyRequest == null){
      var client = http.Client();

      var uri = Uri.parse(url);
      var response = await client.get(uri);
      if(response.statusCode == 200){
        var json = response.body;
        return postFromJson(json);
      }
    } else {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse(url));
      request.body = json.encode(bodyRequest);
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
}