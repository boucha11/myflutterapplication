import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint
import 'package:projetflutter/utils/constants.dart';

class CategorieService {
  late Dio dio;

  CategorieService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getCategories() async {
    try {
      Response response = await dio.get('/categories');
      debugPrint(response.data.toString()); // remplace print
      return response.data;
    } catch (e) {
      debugPrint(e.toString()); // remplace print
      return [];
    }
  }

  Future<Map<String, dynamic>> postCategorie(String nom, dynamic image) async {
    var params = {
      "nomcategorie": nom,
      "imagecategorie": image,
    };

    Response response = await dio.post(
      '/categories',
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
      data: jsonEncode(params),
    );

    debugPrint(response.data.toString()); // Optionnel, pour debug
    return response.data;
  }

  Future<Map<String, dynamic>> updateCategorie(
      String id, String nom, dynamic image) async {
    var params = {
      "nomcategorie": nom,
      "imagecategorie": image,
    };

    Response response = await dio.put(
      '/categories/$id',
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
      data: jsonEncode(params),
    );

    debugPrint(response.data.toString()); // Optionnel, pour debug
    return response.data;
  }
}
