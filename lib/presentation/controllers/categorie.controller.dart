import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorieController extends GetxController {
  final RxBool isPosting = false.obs;
  final RxBool isUpdating = false.obs;
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  Future<bool> createCategorie(
      String nomcategorie, String? imagecategorie) async {
    isPosting.value = true;
    await Future.delayed(const Duration(seconds: 1));

    categories.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'nomcategorie': nomcategorie,
      'imagecategorie': imagecategorie,
    });

    isPosting.value = false;
    Get.snackbar('Succès', 'Catégorie créée!', backgroundColor: Colors.green);
    return true;
  }

  Future<bool> updateCategorie(
      String id, String nomcategorie, String? imagecategorie) async {
    isUpdating.value = true;
    await Future.delayed(const Duration(seconds: 1));

    final index = categories.indexWhere((cat) => cat['id'] == id);
    if (index != -1) {
      categories[index] = {
        'id': id,
        'nomcategorie': nomcategorie,
        'imagecategorie': imagecategorie,
      };
      categories.refresh();
      isUpdating.value = false;
      Get.snackbar('Succès', 'Catégorie mise à jour!',
          backgroundColor: Colors.green);
      return true;
    }

    isUpdating.value = false;
    return false;
  }
}
