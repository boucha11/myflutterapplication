import 'package:projetflutter/data/datasource/models/article.model.dart';
import 'package:projetflutter/data/datasource/services/article.service.dart';

class ArticleRepository {
  final ArticleService artserv;

  ArticleRepository({required this.artserv});

  // Affichage des articles
  Future<List<Article?>> getArticles() async {
    try {
      final articles = await artserv.getArticles();
      return articles.map((art) => Article.fromJson(art)).toList();
    } catch (error) {
      // Retourner une liste vide en cas d'erreur
      return [];
    }
  }
}
