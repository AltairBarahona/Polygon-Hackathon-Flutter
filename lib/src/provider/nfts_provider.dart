import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polygon_hackathon_flutter/src/api/environment.dart';

import '../models/nft.dart';

class NftsProvider {
  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<NftElement>> getNewestNfts() async {
    try {
      Uri url = Uri.parse('${Environment.donatyApiUrl}/nft/get-newest-nfts');

      Map<String, String> headers = {
        'Content-type': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 401) {
        // MySnackbar.show(context, 'Sesión expirada');
        // new SharedPref().logout(context, sessionUser.uid);
      }
      final data = json.decode(response.body); //Categorias
      Nft nftList = Nft.fromJson(data);
      return nftList.nftsList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
