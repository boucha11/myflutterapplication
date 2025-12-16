import 'package:flutter/material.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key}); // Corrigé: utiliser super.key

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  // Supprimer _currentIndex inutilisé
  // int _currentIndex = 0; // ← Supprimé car non utilisé

  int _getCurrentIndex(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/':
        return 0;
      case '/Profile':
        return 0;
      case '/Categories':
        return 1;
      case '/Settings':
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name != '/') {
          Navigator.pushNamed(context, '/');
        }
        break;
      case 1:
        Navigator.pushNamed(context, '/Categories');
        break;
      case 2:
        Navigator.pushNamed(context, '/Settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}
