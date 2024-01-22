import 'dart:convert';

List<AddCart> addCartFromJson(String str) =>
    List<AddCart>.from(json.decode(str).map((x) => AddCart.fromJson(x)));

String addCartToJson(List<AddCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddCart {
  String msg;
  int id;

  AddCart({
    required this.msg,
    required this.id,
  });

  factory AddCart.fromJson(Map<String, dynamic> json) => AddCart(
        msg: json["msg"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "id": id,
      };
}
