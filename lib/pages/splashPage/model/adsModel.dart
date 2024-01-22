// ignore_for_file: file_names

import 'dart:convert';

List<Ads> adsFromJson(String str) =>
    List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

String adsToJson(List<Ads> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
  int id;
  String name;
  String color;
  String link;
  String image;

  Ads({
    required this.id,
    required this.name,
    required this.color,
    required this.link,
    required this.image,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        link: json["link"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "link": link,
        "image": image,
      };
}
