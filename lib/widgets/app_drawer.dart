import 'package:flutter/material.dart';
import 'package:notebookplus/pages/login.dart';
import 'package:notebookplus/pages/note_liste.dart';
import 'package:notebookplus/pages/profile.dart';

import '../models/utilisateur.dart';

class AppDrawer extends StatelessWidget {
  final Utilisateur user;

  const AppDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.username),
            accountEmail: Text('ID : ${user.id}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user.username.isNotEmpty ? user.username[0].toUpperCase() : '',
                style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
              ),
            ),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => NoteListe(user: user)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Profile(user: user)),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
