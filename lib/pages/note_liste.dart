import 'package:flutter/material.dart';

import '../db/note_database.dart';
import '../models/note.dart';
import '../models/utilisateur.dart';
import '../widgets/app_drawer.dart';
import 'note_modifier.dart';

class NoteListe extends StatefulWidget {
  final Utilisateur user;

  const NoteListe({super.key, required this.user});

  @override
  State<NoteListe> createState() => _NoteListeState();
}

class _NoteListeState extends State<NoteListe> {
  List<Note> _notes = [];

  void _loadNotes() async {
    _notes = await DBHelper().getNotes(widget.user.id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  /*void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }*/

  void _deleteNote(int id) async {
    await DBHelper().deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      drawer: AppDrawer(user: widget.user),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(note.titre),
              subtitle: Text(note.contenu),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NoteModifier(note: note, user: widget.user),
                        ),
                      );
                      _loadNotes();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteNote(note.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.blueAccent),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteModifier(user: widget.user)),
          );
          _loadNotes();
        },
      ),
    );
  }
}
