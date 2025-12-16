import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint
import 'package:projetflutter/utils/constants.dart';

class CategorieService {
  late Dio dio;

  // Constructeur : configuration de Dio
  CategorieService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }

  // ================= AFFICHAGE =================
  Future<List<dynamic>> getCategories() async {
    try {
      Response response = await dio.get('/categories');
      debugPrint('getCategories: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('Erreur getCategories: $e');
      return [];
    }
  }

  // ================= AJOUT =================
  Future<Map<String, dynamic>> postCategorie(String nom, dynamic image) async {
    try {
      var params = {
        "nomcategorie": nom,
        "imagecategorie": image,
      };

      Response response = await dio.post(
        '/categories',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );

      debugPrint('postCategorie: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('Erreur postCategorie: $e');
      rethrow;
    }
  }

  // ================= MODIFICATION =================
  Future<Map<String, dynamic>> updateCategorie(
      String id, String nom, dynamic image) async {
    try {
      var params = {
        "nomcategorie": nom,
        "imagecategorie": image,
      };

      Response response = await dio.put(
        '/categories/$id',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );

      debugPrint('updateCategorie: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('Erreur updateCategorie: $e');
      rethrow;
    }
  }

  // ================= SUPPRESSION =================
  Future<String> deleteCategorie(String id) async {
    try {
      Response response = await dio.delete('/categories/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete category');
      }

      debugPrint('deleteCategorie: ${response.data}');
      if (response.data is Map<String, dynamic>) {
        return response.data['message'] ?? 'Suppression réussie';
      }

      return response.data.toString();
    } catch (e) {
      debugPrint('Erreur deleteCategorie: $e');
      rethrow;
    }
  }
}
