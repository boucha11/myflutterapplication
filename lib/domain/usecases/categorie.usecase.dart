import 'package:projetflutter/data/repositories/categorie.repository.dart';
import 'package:projetflutter/domain/entities/categorie.entity.dart';

class CategorieUseCase {
  final CategorieRepository _repository;

  CategorieUseCase({required CategorieRepository repository})
      : _repository = repository;

  // ================= FETCH =================
  Future<List<CategorieEntity?>?> fetchCategories() async {
    final result = await _repository.getCategories();

    final data = result.map((element) {
      return CategorieEntity(
        id: element.id ?? "",
        nomcategorie: element.nomcategorie ?? "",
        imagecategorie: element.imagecategorie ?? "",
      );
    }).toList();

    return data;
  }

  // ================= ADD =================
  Future<CategorieEntity?> addCategorie(String nom, dynamic image) async {
    final result = await _repository.postCategorie(nom, image);

    if (result.isNotEmpty) {
      return CategorieEntity(
        id: result['id'] ?? "",
        nomcategorie: result['nomcategorie'] ?? "",
        imagecategorie: result['imagecategorie'] ?? "",
      );
    }
    return null;
  }

  // ================= UPDATE =================
  Future<CategorieEntity?> updateCategorie(
      String id, String nom, dynamic image) async {
    final result = await _repository.updateCategorie(id, nom, image);

    if (result.isNotEmpty) {
      return CategorieEntity(
        id: result['id'] ?? "",
        nomcategorie: result['nomcategorie'] ?? "",
        imagecategorie: result['imagecategorie'] ?? "",
      );
    }
    return null;
  }
}
