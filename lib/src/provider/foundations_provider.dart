import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polygon_hackathon_flutter/src/api/environment.dart';
import 'package:polygon_hackathon_flutter/src/models/foundation.dart';
import 'package:polygon_hackathon_flutter/src/models/response_api.dart';

class FoundationsProvider extends ChangeNotifier {
  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<FoundationElement>> getFoundations() async {
    try {
      Uri url =
          Uri.parse('${Environment.donatyApiUrl}/foundation/get-foundations');

      Map<String, String> headers = {
        'Content-type': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 401) {
        // MySnackbar.show(context, 'Sesión expirada');
        // new SharedPref().logout(context, sessionUser.uid);
      }
      final data = json.decode(response.body); //Categorias
      Foundation foundations = Foundation.fromJson(data);
      return foundations.foundations;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi> registerFoundation(
      FoundationElement foundation, File profileImages) async {
    try {
      final bytes = profileImages.readAsBytesSync();
      String base64Image = "data:image/png;base64," + base64Encode(bytes);

      Uri url =
          Uri.parse('${Environment.donatyApiUrl}/foundation/create-foundation');

      final response = await http.post(url, body: {
        'name': foundation.name,
        'email': foundation.email,
        'country': foundation.country,
        'description': foundation.description,
        'image': base64Image,
        'ethAddress': foundation.ethAddress,
      });

      final data = json.decode(response.body); //Categorias
      final responseApi = ResponseApi.fromJson(data);
      notifyListeners();
      return responseApi;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }
}
