import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/domain/entities/article.entity.dart';
import 'package:projetflutter/data/datasource/services/article.service.dart';

class ArticleController extends GetxController {
  final ArticleService _articleService;

  ArticleController({required ArticleService articleService})
      : _articleService = articleService;

  var articlesList = <Article>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllArticles();
  }

  Future<void> fetchAllArticles() async {
    try {
      isLoading.value = true;
      final data = await _articleService.getArticles();
      final articles = data.map((item) => Article.fromJson(item)).toList();
      articlesList.assignAll(articles);
    } catch (error) {
      Get.snackbar(
        'Erreur',
        'Impossible de charger les articles: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // AJOUTER CETTE MÉTHODE MANQUANTE
  Future<bool> addArticle(Map<String, dynamic> articleData) async {
    try {
      isLoading.value = true;
      final result = await _articleService.addArticle(articleData);

      if (result['_id'] != null || result['id'] != null) {
        // Recharger la liste des articles
        await fetchAllArticles();
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible d\'ajouter l\'article: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
