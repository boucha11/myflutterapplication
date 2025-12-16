import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/presentation/controllers/categorie.controller.dart';

class AddCategorieScreen extends StatefulWidget {
  const AddCategorieScreen({super.key});

  @override
  State<AddCategorieScreen> createState() => _AddCategorieScreenState();
}

class _AddCategorieScreenState extends State<AddCategorieScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  bool _isLoading = false;
  bool _controllerFound = false;
  late CategorieController _controller;

  @override
  void initState() {
    super.initState();
    // Vérifier et obtenir le contrôleur
    try {
      _controller = Get.find<CategorieController>();
      _controllerFound = true;
    } catch (e) {
      _controllerFound = false;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  Future<void> _ajouterCategorie() async {
    if (!_controllerFound) {
      Get.snackbar(
        'Erreur',
        'Contrôleur non disponible',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Récupérer les données du formulaire
      final nom = _nomController.text.trim();

      // CORRECTION: Utiliser createCategorie au lieu de ajouterCategorie
      // createCategorie prend 2 paramètres: nom et image (optionnelle)
      final success = await _controller.createCategorie(nom, null);

      if (success) {
        // Afficher un message de succès
        Get.snackbar(
          '✅ Succès',
          'Catégorie "$nom" ajoutée avec succès!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Attendre un peu pour voir le message
        await Future.delayed(const Duration(seconds: 1));

        // Retourner à l'écran précédent
        Get.back();
      } else {
        Get.snackbar(
          '❌ Erreur',
          'Impossible d\'ajouter la catégorie',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // En cas d'erreur
      Get.snackbar(
        '❌ Erreur',
        'Impossible d\'ajouter la catégorie: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une catégorie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: _controllerFound ? _buildForm() : _buildErreurControleur(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Titre
            const Text(
              'Nouvelle catégorie',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            // Champ nom
            TextFormField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom de la catégorie',
                hintText: 'Entrez le nom de la catégorie',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                if (value.trim().length < 2) {
                  return 'Le nom doit contenir au moins 2 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Exemples
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Exemples: Électronique, Vêtements, Alimentation, Maison, Sport...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Bouton d'ajout
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _ajouterCategorie,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'AJOUTER LA CATÉGORIE',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Bouton annuler
            const SizedBox(height: 15),
            TextButton(
              onPressed: _isLoading ? null : () => Get.back(),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErreurControleur() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Contrôleur non disponible',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Le contrôleur CategorieController n\'a pas été trouvé.\n'
              'Assurez-vous qu\'il est initialisé avant d\'accéder à cet écran.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'RETOUR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
