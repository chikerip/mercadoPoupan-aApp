import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/catalogPage/models/post.dart';

class RemoteServicesCatalog {
  Future<List<Post>?> getPosts(url, bodyRequest) async {
    var client = http.Client();

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    } else {
      return null;
    }
  }
}
