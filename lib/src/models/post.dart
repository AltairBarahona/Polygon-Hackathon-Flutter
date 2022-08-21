// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.message,
    this.success,
    this.postsList,
  });

  String message;
  bool success;
  List<Result> postsList;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        message: json["message"],
        success: json["success"],
        postsList:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "results": List<dynamic>.from(postsList.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.title,
    this.description,
    this.image,
    this.ethAddress,
    this.createdAt,
    this.updatedAt,
    this.objectId,
  });

  String title;
  String description;
  String image;
  String ethAddress;
  DateTime createdAt;
  DateTime updatedAt;
  String objectId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        ethAddress: json["ethAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        objectId: json["objectId"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "ethAddress": ethAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "objectId": objectId,
      };
}
