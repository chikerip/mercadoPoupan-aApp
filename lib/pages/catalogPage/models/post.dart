// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int id;
    int barcode;
    String name;
    String image;
    List<Market> market;

    Post({
        required this.id,
        required this.barcode,
        required this.name,
        required this.image,
        required this.market,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        barcode: json["barcode"],
        name: json["name"],
        image: json["image"],
        market: List<Market>.from(json["market"].map((x) => Market.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "barcode": barcode,
        "name": name,
        "image": image,
        "market": List<dynamic>.from(market.map((x) => x.toJson())),
    };
}

class Market {
    String market;
    String image;
    double price;
    int promo;

    Market({
        required this.market,
        required this.image,
        required this.price,
        required this.promo,
    });

    factory Market.fromJson(Map<String, dynamic> json) => Market(
        market: json["market"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        promo: json["promo"],
    );

    Map<String, dynamic> toJson() => {
        "market": market,
        "image": image,
        "price": price,
        "promo": promo,
    };
}
