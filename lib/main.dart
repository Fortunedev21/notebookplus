import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() {
  runApp(const NoteBookPlus());
}

class NoteBookPlus extends StatelessWidget {
  const NoteBookPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion de Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Login(),
    );
  }
}
