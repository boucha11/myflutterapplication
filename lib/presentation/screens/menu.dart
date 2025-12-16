import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: choices.length,
        itemBuilder: (context, index) {
          return SelectCard(choice: choices[index]);
        },
      ),
    );
  }
}

class Choice {
  const Choice({
    required this.title,
    required this.icon,
    required this.colorB,
    required this.route,
  });

  final String title;
  final IconData icon;
  final MaterialAccentColor colorB;
  final String route;
}

const List<Choice> choices = <Choice>[
  Choice(
    title: 'Categories',
    icon: Icons.map,
    colorB: Colors.amberAccent,
    route: '/Categories',
  ),
  Choice(
    title: 'Documents',
    icon: Icons.document_scanner,
    colorB: Colors.greenAccent,
    route: '/Documents',
  ),
  Choice(
    title: 'Products',
    icon: Icons.photo_album,
    colorB: Colors.pinkAccent,
    route: '/Products',
  ),
  Choice(
    title: 'Items',
    icon: Icons.shopping_cart,
    colorB: Colors.purpleAccent,
    route: '/Items',
  ),
  Choice(
    title: 'Subscribe',
    icon: Icons.subscriptions,
    colorB: Colors.lightBlueAccent,
    route: '/Subscribe',
  ),
  Choice(
    title: 'Exit',
    icon: Icons.exit_to_app,
    colorB: Colors.redAccent,
    route: '/Exit',
  ),
];

class SelectCard extends StatelessWidget {
  const SelectCard({super.key, required this.choice});
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(choice.route);
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(choice.icon, size: 50, color: choice.colorB),
            const SizedBox(height: 10),
            Text(
              choice.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
