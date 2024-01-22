import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/loginPage/models/post.dart';

class RemoteServicesLogin {
  Future<List<Post>?> getPosts(url, bodyRequest) async {
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
