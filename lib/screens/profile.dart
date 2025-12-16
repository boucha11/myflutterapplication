import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // Photo de profil
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blue[100],
              child: const Icon(
                Icons.person,
                size: 80,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            // Nom
            const Text(
              'Mohamed Yessin Bouchaala',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Email
            const Text(
              'mohamedyessinb@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Informations
            _buildProfileCard(
              icon: Icons.phone,
              title: 'Phone',
              value: '+216 XX XXX XXX',
            ),
            _buildProfileCard(
              icon: Icons.location_on,
              title: 'Address',
              value: 'Tunis, Tunisia',
            ),
            _buildProfileCard(
              icon: Icons.calendar_today,
              title: 'Member Since',
              value: 'January 2024',
            ),

            const SizedBox(height: 30),

            // Bouton d'édition
            ElevatedButton.icon(
              onPressed: () {
                // Action d'édition du profil
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
