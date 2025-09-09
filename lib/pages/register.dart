import 'package:flutter/material.dart';
import 'package:notebookplus/pages/login.dart';

import '../db/note_database.dart';
import '../models/utilisateur.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final user = Utilisateur(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      try {
        await DBHelper().insertUser(user);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Inscription réussie')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Login()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Utilisateur déjà existant')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: 250, height: 250),
          Text(
            "NoteBook+",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Entrez un nom d\'utilisateur' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe',
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Entrez un mot de passe' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signup,
                    child: const Text('S\'inscrire'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
