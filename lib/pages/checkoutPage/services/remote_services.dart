import 'package:http/http.dart' as http;
import 'package:mercadopoupanca/pages/checkoutPage/models/post.dart';
import 'package:mercadopoupanca/pages/statusShopPage/model/post.dart';

class RemoteServicesCart {
  Future<List<Promo>?> getDiscount(url) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));
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

  Future<List<AddCart>?> postCart(url, token, body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = body;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      return addCartFromJson(json);
    } else {
      return null;
    }
  }
}
