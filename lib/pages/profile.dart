import 'package:flutter/material.dart';

import '../models/utilisateur.dart';
import '../widgets/app_drawer.dart';

class Profile extends StatelessWidget {
  final Utilisateur user;

  const Profile({super.key, required this.user});

  /*void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      drawer: AppDrawer(user: user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Nom d\'utilisateur : ${user.username}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'ID utilisateur : ${user.id}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
