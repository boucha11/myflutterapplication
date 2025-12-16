import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetflutter/presentation/controllers/user.controller.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Initialisation du contrôleur
  final AuthController _controller = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordController2;

  // show the password or not
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordController2 = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  // Méthode pour gérer l'inscription
  Future<void> _handleRegister() async {
    // Retourne true si le formulaire est valide, sinon false
    if (_formKey.currentState!.validate()) {
      try {
        // Appelle la méthode du controller GetX avec les valeurs des champs
        await _controller.register(
          _usernameController.text,
          _passwordController.text,
        );

        // Vérifier si le widget est toujours monté
        if (!mounted) return;

        // Si l'ajout est réussi, afficher message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscription réussie')),
        );

        // Redirection vers la page login
        Navigator.of(context).pushNamed('/Login');
      } catch (error) {
        // Si une erreur survient, afficher un message d'erreur
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Nom d'utilisateur",
                labelText: "Nom d'utilisateur",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom d\'utilisateur';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: _isObscure,
              controller: _passwordController,
              decoration: InputDecoration(
                icon: const Icon(Icons.key_rounded),
                hintText: "Mot de passe",
                labelText: "Mot de passe",
                // this button is used to toggle the password visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un mot de passe';
                }
                if (value.length < 6) {
                  return 'Le mot de passe doit contenir au moins 6 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: _isObscure2,
              controller: _passwordController2,
              decoration: InputDecoration(
                icon: const Icon(Icons.key_outlined),
                hintText: "Confirmer le mot de passe",
                labelText: "Confirmer le mot de passe",
                // this button is used to toggle the password visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure2 = !_isObscure2;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez confirmer votre mot de passe';
                }
                if (value != _passwordController.text) {
                  return "Les mots de passe ne correspondent pas";
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _handleRegister, // Utilisation de la méthode séparée
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Vous avez déjà un compte ? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Login');
                  },
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
