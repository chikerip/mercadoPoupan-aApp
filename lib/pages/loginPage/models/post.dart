// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    String token;
    int admin;

    Post({
        required this.token,
        required this.admin,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        token: json["token"],
        admin: json["admin"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "admin": admin,
    };
}