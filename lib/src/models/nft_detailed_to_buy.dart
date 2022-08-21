// To parse this JSON data, do
//
//     final nft = nftFromJson(jsonString);

import 'dart:convert';

NftDetailed nftFromJson(String str) => NftDetailed.fromJson(json.decode(str));

String nftToJson(NftDetailed data) => json.encode(data.toJson());

class NftDetailed {
  NftDetailed({
    this.success,
    this.message,
    this.nft,
    this.marketAddress,
  });

  bool success;
  String message;
  NftDetailedElement nft;
  String marketAddress;

  factory NftDetailed.fromJson(Map<String, dynamic> json) => NftDetailed(
        success: json["success"],
        message: json["message"],
        nft: NftDetailedElement.fromJson(json["nft"]),
        marketAddress: json["marketAddress"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "nft": nft.toJson(),
        "marketAddress": marketAddress,
      };
}

class NftDetailedElement {
  NftDetailedElement({
    this.address,
    this.nftContract,
    this.owner,
    this.owned,
    this.description,
    this.tokenId,
    this.img,
    this.title,
    this.price,
    this.cause,
    this.logoFoundation,
    this.nameFoundation,
    this.status,
    this.marketAddress,
  });

  String address;
  String nftContract;
  String owner;
  String owned;
  String description;
  String tokenId;
  String img;
  String title;
  int price;
  String cause;
  String logoFoundation;
  String nameFoundation;
  bool status;
  String marketAddress;

  factory NftDetailedElement.fromJson(Map<String, dynamic> json) =>
      NftDetailedElement(
        nftContract: json["nftContract"],
        owner: json["owner"],
        owned: json["owned"],
        description: json["description"],
        tokenId: json["tokenId"],
        img: json["img"],
        title: json["title"],
        price: json["price"],
        cause: json["cause"],
        logoFoundation: json["logo_foundation"],
        nameFoundation: json["name_foundation"],
        status: json["status"],
        marketAddress: json["marketAddress"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "nftContract": nftContract,
        "owner": owner,
        "owned": owned,
        "description": description,
        "tokenId": tokenId,
        "img": img,
        "title": title,
        "price": price,
        "cause": cause,
        "logo_foundation": logoFoundation,
        "name_foundation": nameFoundation,
        "status": status,
        "marketAddress": marketAddress,
      };
}
