import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ArticleService {
  late Dio dio;
  final String baseUrl = 'https://votre-api.com'; // Remplacez par votre URL

  ArticleService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30), // Augmentez le timeout
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getArticles() async {
    try {
      Response response = await dio.get('/articles');
      debugPrint('GET Articles response: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('GET Articles error: $e');
      // Retourner des données mockées pour le test
      return [
        {
          '_id': '1',
          'designation': 'Laptop Dell XPS 13',
          'prix': 1299.99,
          'qtestock': 10,
          'imageart': 'https://via.placeholder.com/150',
          'reference': 'REF001',
          'marque': 'Dell'
        },
      ];
    }
  }

  Future<Map<String, dynamic>> addArticle(
      Map<String, dynamic> articleData) async {
    try {
      debugPrint('Envoi POST avec données: $articleData');

      // Nettoyer les données null
      final cleanData = Map<String, dynamic>.from(articleData)
        ..removeWhere((key, value) => value == null);

      Response response = await dio.post(
        '/articles',
        data: jsonEncode(cleanData),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      debugPrint('POST Article response: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('POST Article error: $e');
      rethrow;
    }
  }
}
