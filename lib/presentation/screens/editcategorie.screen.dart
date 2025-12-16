import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/presentation/controllers/categorie.controller.dart';

class EditCategorieScreen extends StatefulWidget {
  final String id;
  final String nomcategorie;
  final String? imagecategorie;

  const EditCategorieScreen({
    super.key,
    required this.id,
    required this.nomcategorie,
    this.imagecategorie,
  });

  @override
  State<EditCategorieScreen> createState() => _EditCategorieScreenState();
}

class _EditCategorieScreenState extends State<EditCategorieScreen> {
  final CategorieController categorieController =
      Get.find<CategorieController>();
  final TextEditingController _nomcategorieController = TextEditingController();
  final TextEditingController _imagecategorieController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomcategorieController.text = widget.nomcategorie;
    _imagecategorieController.text = widget.imagecategorie ?? '';
  }

  @override
  void dispose() {
    _nomcategorieController.dispose();
    _imagecategorieController.dispose();
    super.dispose();
  }

  Future<void> _updateCategorie() async {
    if (_formKey.currentState!.validate()) {
      final success = await categorieController.updateCategorie(
        widget.id,
        _nomcategorieController.text,
        _imagecategorieController.text.isNotEmpty
            ? _imagecategorieController.text
            : null,
      );

      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Category updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update category',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
        actions: [
          Obx(() => categorieController.isUpdating.value
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : Container()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomcategorieController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imagecategorieController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: categorieController.isUpdating.value
                        ? null
                        : _updateCategorie,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: categorieController.isUpdating.value
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Updating...'),
                            ],
                          )
                        : const Text(
                            'Update Category',
                            style: TextStyle(fontSize: 16),
                          ),
                  )),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
