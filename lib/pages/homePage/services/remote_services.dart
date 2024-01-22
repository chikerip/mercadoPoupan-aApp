import 'dart:convert';

import 'package:mercadopoupanca/pages/homePage/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Post>?> getPosts(url, bodyRequest) async {
    if (bodyRequest == null) {
      var client = http.Client();

      var uri = Uri.parse(url);
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return postFromJson(json);
      } else {
        return null;
      }
    } else {
      var headers = {'Content-Type': 'application/json'};
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
