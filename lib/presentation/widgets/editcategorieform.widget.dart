import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/domain/entities/categorie.entity.dart';
import 'package:projetflutter/presentation/controllers/categorie.controller.dart';

class Editcategorieform extends StatelessWidget {
  final CategorieEntity categorie;

  const Editcategorieform({
    super.key,
    required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategorieController>();
    final TextEditingController nameController =
        TextEditingController(text: categorie.nomcategorie);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nom de la catégorie',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => controller.isPosting.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.updateCategorie(
                        categorie.id,
                        nameController.text,
                        categorie.imagecategorie,
                      );
                    },
                    child: const Text('Modifier'),
                  ),
          ),
        ],
      ),
    );
  }
}
