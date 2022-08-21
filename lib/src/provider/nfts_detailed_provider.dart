import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polygon_hackathon_flutter/src/api/environment.dart';
import 'package:polygon_hackathon_flutter/src/models/nft_detailed_to_buy.dart';

class NftsDetailedProvider {
  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<NftDetailedElement> getDetailedNftInformation(
      String address, String id) async {
    try {
      Uri url = Uri.parse(
          '${Environment.donatyApiUrl}/nft/get-nfts-from-address-and-tokenid/$address/$id');

      Map<String, String> headers = {
        'Content-type': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 401) {
        // MySnackbar.show(context, 'Sesión expirada');
        // new SharedPref().logout(context, sessionUser.uid);
      }
      final data = json.decode(response.body); //Categorias
      NftDetailedElement nftDetailed = NftDetailedElement.fromJson(data["nft"]);
      return nftDetailed;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
