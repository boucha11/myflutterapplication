import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategorieForm extends StatefulWidget {
  const AddCategorieForm({super.key});

  @override
  State<AddCategorieForm> createState() => _AddCategorieFormState();
}

class _AddCategorieFormState extends State<AddCategorieForm> {
  final TextEditingController _nomcategorieController = TextEditingController();
  final TextEditingController _imagecategorieController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool isEditMode;
  late Map<String, dynamic>? args;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Récupérer les arguments passés via GetX
    args = Get.arguments;
    isEditMode = args != null && args is Map<String, dynamic>;

    // Pré-remplir les champs si en mode édition
    if (isEditMode) {
      _nomcategorieController.text = args!['nomcategorie'] ?? '';
      _imagecategorieController.text = args!['imagecategorie'] ?? '';
    }
  }

  @override
  void dispose() {
    _nomcategorieController.dispose();
    _imagecategorieController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isProcessing = true);

      // Simuler un délai de traitement
      await Future.delayed(const Duration(seconds: 1));

      final nom = _nomcategorieController.text;

      if (isEditMode && args != null) {
        // Mode édition
        Get.back();
        Get.snackbar(
          'Succès (TEST)',
          'Catégorie "$nom" aurait été mise à jour',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Mode création
        Get.back();
        Get.snackbar(
          'Succès (TEST)',
          'Catégorie "$nom" aurait été créée',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomcategorieController,
              decoration: const InputDecoration(
                labelText: 'Nom de la catégorie *',
                border: OutlineInputBorder(),
                hintText: 'Entrez le nom de la catégorie',
                prefixIcon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom de catégorie';
                }
                if (value.length < 2) {
                  return 'Le nom doit contenir au moins 2 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imagecategorieController,
              decoration: const InputDecoration(
                labelText: 'URL de l\'image (optionnel)',
                border: OutlineInputBorder(),
                hintText: 'https://exemple.com/image.jpg',
                prefixIcon: Icon(Icons.image),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isProcessing ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEditMode ? Colors.blue : Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isProcessing
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
                        Text('Traitement en cours...'),
                      ],
                    )
                  : Text(
                      isEditMode ? 'Mettre à jour' : 'Créer la catégorie',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: isProcessing ? null : () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
    );
  }
}
