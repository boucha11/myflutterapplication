import 'package:logger/logger.dart'; // Add this import
import 'package:projetflutter/data/datasource/models/article.model.dart';
import 'package:projetflutter/data/datasource/services/article.service.dart';

class ArticleRepository {
  final ArticleService artserv;
  final Logger _logger = Logger(); // Create logger instance

  ArticleRepository({required this.artserv});

  Future<List<Article?>> getArticles() async {
    try {
      final articles = await artserv.getArticles();
      return articles.map((art) => Article.fromJson(art)).toList();
    } catch (error) {
      _logger.e("Error fetching articles", error: error); // Use logger
      return [];
    }
  }
}
