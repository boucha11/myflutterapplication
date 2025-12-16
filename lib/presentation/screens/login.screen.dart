import 'package:flutter/material.dart';
import 'package:projetflutter/presentation/widgets/loginform.widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.purpleAccent,
        title: const Text("Login"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.person_2_outlined),
        ),
      ),
      body: const LoginForm(),
    );
  }
}
