import 'package:projetflutter/data/repositories/article.repository.dart';
import 'package:projetflutter/domain/entities/article.entity.dart';

class ArticleUseCase {
  final ArticleRepository _repository; // Paramètre nommé "repository"

  ArticleUseCase(
      {required ArticleRepository repository}) // Paramètre nommé "repository"
      : _repository = repository;

  Future<List<ArticleEntity?>> fetchArticles() async {
    final result = await _repository.getArticles();
    final data = result.map((element) {
      return ArticleEntity(
        id: element?.id ?? "",
        designation: element?.designation ?? "",
        prix: element?.prix ?? 0,
        qtestock: element?.qtestock ?? 0,
        imageart: element?.imageart ?? "",
      );
    }).toList();
    return data;
  }
}
