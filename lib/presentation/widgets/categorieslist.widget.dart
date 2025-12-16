import 'package:flutter/material.dart';
import 'package:projetflutter/domain/entities/categorie.entity.dart';

class CategoriesListWidget extends StatelessWidget {
  final CategorieEntity categories;
  const CategoriesListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: categories.imagecategorie != null &&
                categories.imagecategorie!.isNotEmpty
            ? Image.network(
                categories.imagecategorie!,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              )
            : Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.category, color: Colors.blue),
              ),
        title: Text(categories.nomcategorie),
      ),
    );
  }
}
