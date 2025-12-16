import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Écran TEST ULTRA SIMPLE
class TestAddScreen extends StatelessWidget {
  const TestAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEST ULTIME'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TEST BOUTON',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // BOUTON 1 : Le plus simple possible
            ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'SUCCÈS',
                  'Bouton 1 fonctionne!',
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                );
              },
              child: const Text('BOUTON 1 (Snackbar seulement)'),
            ),
            const SizedBox(height: 20),

            // BOUTON 2 : Avec retour
            ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'SUCCÈS',
                  'Retour dans 1 seconde...',
                  backgroundColor: Colors.blue,
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Get.back();
                });
              },
              child: const Text('BOUTON 2 (Snackbar + retour)'),
            ),
            const SizedBox(height: 20),

            // BOUTON 3 : Test de pression
            GestureDetector(
              onTap: () {
                Get.snackbar('Gesture', 'GestureDetector fonctionne');
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.orange,
                child: const Text(
                  'GESTURE DETECTOR (test différent)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Écran de liste TEST
class TestListScreen extends StatelessWidget {
  const TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEST LISTE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Écran de liste de test'),
            const SizedBox(height: 30),

            // Bouton pour ouvrir l'écran d'ajout
            ElevatedButton(
              onPressed: () {
                Get.to(() => const TestAddScreen());
              },
              child: const Text('OUVRIR ÉCRAN D\'AJOUT (TEST)'),
            ),
            const SizedBox(height: 20),

            // Bouton FAB simulé
            FloatingActionButton(
              onPressed: () {
                Get.to(() => const TestAddScreen());
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
