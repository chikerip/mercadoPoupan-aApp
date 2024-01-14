import 'dart:convert';

List<Shop> shopFromJson(String str) => List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

String shopToJson(List<Shop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shop {
    String image;
    int product;
    String name;
    String store;
    String storeImg;
    double price;
    int promo;
    int amount;

    Shop({
        required this.image,
        required this.product,
        required this.name,
        required this.store,
        required this.storeImg,
        required this.price,
        required this.promo,
        required this.amount,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        image: json["image"],
        product: json["product"],
        name: json["name"],
        store: json["store"],
        storeImg: json["storeImg"],
        price: json["price"]?.toDouble(),
        promo: json["promo"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "product": product,
        "name": name,
        "store": store,
        "storeImg": storeImg,
        "price": price,
        "promo": promo,
        "amount": amount,
    };
}