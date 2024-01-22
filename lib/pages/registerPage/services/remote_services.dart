import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/registerPage/models/post.dart';

class RemoteServicesRegister {
  Future<List<Post>?> getPosts(url, bodyRequest) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(bodyRequest);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      return postFromJson(json);
    } else {
      // ignore: unused_local_variable
      var json = await response.stream.bytesToString();
      return null;
    }
  }
}
