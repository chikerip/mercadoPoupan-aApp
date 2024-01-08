// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    String image;
    String name;
    String adress;
    String phoneNumber;
    String nif;

    Post({
        required this.image,
        required this.name,
        required this.adress,
        required this.phoneNumber,
        required this.nif,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        image: json["image"],
        name: json["name"],
        adress: json["adress"],
        phoneNumber: json["phoneNumber"],
        nif: json["nif"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "adress": adress,
        "phoneNumber": phoneNumber,
        "nif": nif,
    };
}
