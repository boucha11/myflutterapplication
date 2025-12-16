import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  // Liste complète des éléments du menu
  final List<Map<String, dynamic>> menuItems = const [
    {
      'title': 'Home',
      'icon': Icons.home,
      'color': Colors.blue,
      'route': '/',
    },
    {
      'title': 'Categories',
      'icon': Icons.category,
      'color': Colors.green,
      'route': '/Categories',
    },
    {
      'title': 'Documents',
      'icon': Icons.description,
      'color': Colors.orange,
      'route': '/Documents',
    },
    {
      'title': 'Products',
      'icon': Icons.shopping_bag,
      'color': Colors.purple,
      'route': '/Products',
    },
    {
      'title': 'Synchronization',
      'icon': Icons.sync,
      'color': Colors.teal,
      'route': '/Sync',
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
      'color': Colors.brown,
      'route': '/Settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFE3F2FD)],
        ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _buildMenuItem(
            context: context,
            title: item['title'] as String,
            icon: item['icon'] as IconData,
            color: item['color'] as Color,
            route: item['route'] as String,
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          _handleMenuItemTap(context, title, route);
        },
        borderRadius: BorderRadius.circular(15),
        splashColor: color.withAlpha(40), // Remplacer withOpacity par withAlpha
        highlightColor:
            color.withAlpha(20), // Remplacer withOpacity par withAlpha
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    color.withAlpha(25), // Remplacer withOpacity par withAlpha
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction séparée pour gérer le tap
  void _handleMenuItemTap(BuildContext context, String title, String route) {
    if (route == '/') {
      // Already on home page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You are already on $title page'),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // Utiliser un bloc try-catch au lieu de catchError
    try {
      Navigator.pushNamed(context, route);
    } catch (error) {
      // Afficher un message d'erreur
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Page $title not available yet'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }
}
