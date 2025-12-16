import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key}); // Constructeur const

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Application'),
      backgroundColor: Colors.blue,
      centerTitle: true,
      actions: const [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: null, // Mettez null ou une fonction const
        ),
      ],
    );
  }
}
