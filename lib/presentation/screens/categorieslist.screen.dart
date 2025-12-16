import 'package:flutter/material.dart';

class CategoriesListScreen extends StatelessWidget {
  const CategoriesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            tooltip: 'Ajouter une catégorie',
          ),
        ],
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.category, color: Colors.blue),
            title: Text('Électronique'),
            subtitle: Text('ID: 1'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Icon(Icons.delete, color: Colors.red, size: 20),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.green),
            title: Text('Vêtements'),
            subtitle: Text('ID: 2'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Icon(Icons.delete, color: Colors.red, size: 20),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.orange),
            title: Text('Alimentation'),
            subtitle: Text('ID: 3'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Icon(Icons.delete, color: Colors.red, size: 20),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        tooltip: 'Ajouter une catégorie',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
