// To parse this JSON data, do
//
//     final foundation = foundationFromJson(jsonString);

import 'dart:convert';

Foundation foundationFromJson(String str) =>
    Foundation.fromJson(json.decode(str));

String foundationToJson(Foundation data) => json.encode(data.toJson());

class Foundation {
  Foundation({
    this.message,
    this.foundations,
    this.success,
  });

  String message;
  List<FoundationElement> foundations;
  bool success;

  factory Foundation.fromJson(Map<String, dynamic> json) => Foundation(
        message: json["message"],
        foundations: List<FoundationElement>.from(
            json["foundations"].map((x) => FoundationElement.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "foundations": List<dynamic>.from(foundations.map((x) => x.toJson())),
        "success": success,
      };
}

class FoundationElement {
  FoundationElement({
    this.name,
    this.email,
    this.country,
    this.description,
    this.image,
    this.ethAddress,
    this.createdAt,
    this.updatedAt,
    this.objectId,
  });

  String name;
  String email;
  String country;
  String description;
  String image;
  String ethAddress;
  DateTime createdAt;
  DateTime updatedAt;
  String objectId;

  factory FoundationElement.fromJson(Map<String, dynamic> json) =>
      FoundationElement(
        name: json["name"],
        email: json["email"],
        country: json["country"],
        description: json["description"],
        image: json["image"],
        ethAddress: json["ethAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        objectId: json["objectId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "country": country,
        "description": description,
        "image": image,
        "ethAddress": ethAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "objectId": objectId,
      };
}
