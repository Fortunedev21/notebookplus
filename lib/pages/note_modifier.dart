import 'package:flutter/material.dart';

import '../db/note_database.dart';
import '../models/note.dart';
import '../models/utilisateur.dart';

class NoteModifier extends StatefulWidget {
  final Note? note;
  final Utilisateur user;

  const NoteModifier({super.key, this.note, required this.user});

  @override
  State<NoteModifier> createState() => _NoteModifierState();
}

class _NoteModifierState extends State<NoteModifier> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.titre;
      _contentController.text = widget.note!.contenu;
    }
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      if (widget.note == null) {
        await DBHelper().insertNote(
          Note(titre: _titleController.text, contenu: _contentController.text),
          widget.user.id!,
        );
      } else {
        await DBHelper().updateNote(
          Note(
            id: widget.note!.id,
            titre: _titleController.text,
            contenu: _contentController.text,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nouvelle Note' : 'Modifier Note'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Entrez un titre' : null,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Contenu',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
