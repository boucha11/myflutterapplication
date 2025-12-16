import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetflutter/presentation/controllers/article.controller.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final ArticleController _controller = Get.find<ArticleController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _qtestockController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();

  File? _imageFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Créer les données du produit
      Map<String, dynamic> articleData = {
        'designation': _designationController.text,
        'prix': double.parse(_prixController.text),
        'qtestock': int.parse(_qtestockController.text),
      };

      // Ajouter les champs optionnels seulement s'ils ne sont pas vides
      if (_referenceController.text.isNotEmpty) {
        articleData['reference'] = _referenceController.text;
      }
      if (_marqueController.text.isNotEmpty) {
        articleData['marque'] = _marqueController.text;
      }
      if (_imageFile != null) {
        articleData['imageart'] = await _convertImageToBase64(_imageFile!);
      }

      debugPrint('=== DONNÉES ENVOYÉES ===');
      debugPrint('Article: $articleData');

      // Appeler le service pour ajouter l'article
      final success = await _controller.addArticle(articleData);

      if (success) {
        Get.snackbar(
          '✅ Succès',
          'Produit ajouté avec succès!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
        );

        // Attendre un peu avant de revenir
        await Future.delayed(const Duration(milliseconds: 1500));
        Get.back();
      } else {
        Get.snackbar(
          '❌ Erreur',
          'Impossible d\'ajouter le produit',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        '❌ Erreur',
        'Une erreur est survenue: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      debugPrint('=== ERREUR DÉTAILLÉE ===');
      debugPrint('Erreur: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _convertImageToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } catch (e) {
      debugPrint('Erreur de conversion image: $e');
      return null;
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir une image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Prendre une photo'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choisir depuis la galerie'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau produit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _submitForm,
            tooltip: 'Enregistrer',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              const Text(
                'Ajouter un nouveau produit',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Section image
              const Text(
                'Image du produit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              Center(
                child: GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _imageFile!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Ajouté const ici
                              Icon(Icons.add_photo_alternate,
                                  size: 50, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                'Ajouter une image',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Section informations
              const Text(
                'Informations du produit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),

              // Champ désignation
              TextFormField(
                controller: _designationController,
                decoration: InputDecoration(
                  labelText: 'Nom du produit *',
                  hintText: 'Ex: iPhone 14 Pro Max 256Go',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.shopping_bag),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le nom du produit';
                  }
                  if (value.length < 3) {
                    return 'Le nom doit contenir au moins 3 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Champ prix
              TextFormField(
                controller: _prixController,
                decoration: InputDecoration(
                  labelText: 'Prix *',
                  hintText: 'Ex: 1299.99',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.euro),
                  suffixText: '€',
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le prix';
                  }
                  final price = double.tryParse(value);
                  if (price == null) {
                    return 'Veuillez saisir un nombre valide';
                  }
                  if (price <= 0) {
                    return 'Le prix doit être supérieur à 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Champ quantité
              TextFormField(
                controller: _qtestockController,
                decoration: InputDecoration(
                  labelText: 'Quantité en stock *',
                  hintText: 'Ex: 50',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.inventory),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir la quantité';
                  }
                  final qty = int.tryParse(value);
                  if (qty == null) {
                    return 'Veuillez saisir un nombre entier';
                  }
                  if (qty < 0) {
                    return 'La quantité ne peut pas être négative';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Champ référence
              TextFormField(
                controller: _referenceController,
                decoration: InputDecoration(
                  labelText: 'Référence',
                  hintText: 'Ex: APP-IPH14-256-BLK',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.confirmation_number),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 15),

              // Champ marque
              TextFormField(
                controller: _marqueController,
                decoration: InputDecoration(
                  labelText: 'Marque',
                  hintText: 'Ex: Apple',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.branding_watermark),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 30),

              // Bouton d'ajout
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_circle_outline),
                            SizedBox(width: 10),
                            Text(
                              'AJOUTER LE PRODUIT',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 10),

              // Bouton annuler
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text(
                    'ANNULER',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
