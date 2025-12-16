import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // En-tête du drawer (peut être const)
          const UserAccountsDrawerHeader(
            accountName: Text('Mohamed Yessin Bouchaala'),
            accountEmail: Text('mohamedyessinb@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'M',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),

          // Menu items d'authentification
          _buildDrawerItem(
            context: context,
            icon: Icons.login,
            title: 'Login',
            route: '/Login',
            color: Colors.green,
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.app_registration,
            title: 'Register',
            route: '/Register',
            color: Colors.blue,
          ),

          const Divider(color: Colors.grey),

          // Menu items principaux
          _buildDrawerItem(
            context: context,
            icon: Icons.person,
            title: 'Profile',
            route: '/Profile',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.subscriptions,
            title: 'Subscribe',
            route: '/Subscribe',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.shopping_cart,
            title: 'Items',
            route: '/Products',
          ),
          // NOUVEAU: Item Shopping avec panier persistant
          _buildDrawerItem(
            context: context,
            icon: Icons.shopping_bag,
            title: 'Shopping',
            route: '/Shopping',
            color: Colors.orange,
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.description,
            title: 'Documents',
            route: '/Documents',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.settings,
            title: 'Settings',
            route: '/Settings',
          ),

          const Divider(color: Colors.grey),

          _buildDrawerItem(
            context: context,
            icon: Icons.exit_to_app,
            title: 'Exit',
            route: '/Exit',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.blue,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Fermer le drawer d'abord
        Navigator.pop(context);

        // Naviguer vers la route avec gestion d'erreur
        _navigateToRoute(context, route, title);
      },
    );
  }

  // Fonction séparée pour la navigation avec gestion d'erreur
  void _navigateToRoute(BuildContext context, String route, String title) {
    try {
      Navigator.pushNamed(context, route);
    } catch (error) {
      // Utiliser un post-frame callback pour s'assurer que le contexte est valide
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cannot navigate to $title'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }
}
