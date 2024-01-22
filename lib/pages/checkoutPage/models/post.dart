import 'dart:convert';

List<Promo> postFromJson(String str) =>
    List<Promo>.from(json.decode(str).map((x) => Promo.fromJson(x)));

String postToJson(List<Promo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promo {
  int promoCode;

  Promo({
    required this.promoCode,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        promoCode: json["promoCode"],
      );

  Map<String, dynamic> toJson() => {
        "promoCode": promoCode,
      };
}
