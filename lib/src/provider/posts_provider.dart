import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:polygon_hackathon_flutter/src/api/environment.dart';
import 'package:polygon_hackathon_flutter/src/models/post.dart';

class PostsProvider {
  BuildContext context;

  // ignore: missing_return
  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<Result>> getPostsByFoundationWallet(String ethAddress) async {
    try {
      Uri url = Uri.parse(
          '${Environment.donatyApiUrl}/post/get-posts-by-foundation-wallet/$ethAddress');

      Map<String, String> headers = {
        'Content-type': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 401) {
        // MySnackbar.show(context, 'Sesión expirada');
        // new SharedPref().logout(context, sessionUser.uid);
      }
      final data = json.decode(response.body); //Categorias
      Post postsList = Post.fromJson(data);
      return postsList.postsList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
