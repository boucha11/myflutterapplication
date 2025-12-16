import 'package:flutter/material.dart';
import 'package:projetflutter/presentation/widgets/registerform.widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.purpleAccent,
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.app_registration_outlined),
        ),
      ),
      body: const RegisterForm(),
    );
  }
}
