// To parse this JSON data, do
//
//     final nft = nftFromJson(jsonString);

import 'dart:convert';

Nft nftFromJson(String str) => Nft.fromJson(json.decode(str));

String nftToJson(Nft data) => json.encode(data.toJson());

class Nft {
  Nft({
    this.success,
    this.message,
    this.nftsList,
  });

  bool success;
  String message;
  List<NftElement> nftsList;

  factory Nft.fromJson(Map<String, dynamic> json) => Nft(
        success: json["success"],
        message: json["message"],
        nftsList: List<NftElement>.from(
            json["nfts"].map((x) => NftElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "nfts": List<dynamic>.from(nftsList.map((x) => x.toJson())),
      };
}

class NftElement {
  NftElement({
    this.address,
    this.nftContract,
    this.owner,
    this.tokenId,
    this.img,
    this.title,
    this.price,
    this.status,
    this.logoFoundation,
    this.nameFoundation,
  });

  String address;
  String nftContract;
  String owner;
  String tokenId;
  String img;
  String title;
  dynamic price;
  bool status;
  String logoFoundation;
  String nameFoundation;

  factory NftElement.fromJson(Map<String, dynamic> json) => NftElement(
        address: json["address"],
        nftContract: json["nftContract"],
        owner: json["owner"],
        tokenId: json["tokenId"],
        img: json["img"],
        title: json["title"],
        price: json["price"],
        status: json["status"],
        logoFoundation: json["logo_foundation"],
        nameFoundation: json["name_foundation"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "nftContract": nftContract,
        "owner": owner,
        "tokenId": tokenId,
        "img": img,
        "title": title,
        "price": price,
        "status": status,
        "logo_foundation": logoFoundation,
        "name_foundation": nameFoundation,
      };
}
