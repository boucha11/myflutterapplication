import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: [
          _sectionTitle('Compte'),
          _settingItem(
            icon: Icons.person,
            title: 'Profil',
            subtitle: 'Modifier les informations personnelles',
            onTap: () {},
          ),
          _settingItem(
            icon: Icons.lock,
            title: 'Changer le mot de passe',
            subtitle: 'Sécurité du compte',
            onTap: () {},
          ),
          _sectionTitle('Application'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Mode sombre'),
            subtitle: const Text('Activer le thème sombre'),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Recevoir des notifications'),
            value: true,
            onChanged: (value) {},
          ),
          _sectionTitle('Sécurité'),
          _settingItem(
            icon: Icons.fingerprint,
            title: 'Authentification biométrique',
            subtitle: 'Empreinte digitale / Face ID',
            onTap: () {},
          ),
          _settingItem(
            icon: Icons.privacy_tip,
            title: 'Confidentialité',
            subtitle: 'Politique de confidentialité',
            onTap: () {},
          ),
          _sectionTitle('Stockage'),
          _settingItem(
            icon: Icons.delete,
            title: 'Vider le cache',
            subtitle: 'Libérer de l’espace',
            onTap: () {},
          ),
          _sectionTitle('À propos'),
          _settingItem(
            icon: Icons.info,
            title: 'Version de l’application',
            subtitle: 'v1.0.0',
            onTap: () {},
          ),
          _settingItem(
            icon: Icons.help,
            title: 'Support',
            subtitle: 'Contacter le support',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================
  // Widgets réutilisables
  // =======================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
