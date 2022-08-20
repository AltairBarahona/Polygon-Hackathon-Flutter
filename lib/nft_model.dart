import 'dart:convert';

Nft productFromJson(String str) => Nft.fromJson(json.decode(str));

String productToJson(Nft data) => json.encode(data.toJson());

class Nft {
  String id;
  String name;
  String description;
  String image1;
  double price;
  Nft({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.price,
  });

  factory Nft.fromJson(Map<String, dynamic> json) => Nft(
        id: json["id"] is int ? json["id"].toString() : json['id'],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        price: json['price'] is String
            ? double.parse(json["price"])
            : isInteger(json["price"])
                ? json["price"].toDouble()
                : json['price'],
        // idCategory: json["id_category"] is String ? int.parse(json["id_category"]): json["id_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "price": price,
      };
  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  Nft.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Nft nft = Nft.fromJson(item);
    });
  }
}
