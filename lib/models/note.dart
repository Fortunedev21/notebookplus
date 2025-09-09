class Note {
  final int? id;
  final String titre;
  final String contenu;

  Note({this.id, required this.titre, required this.contenu});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': titre, 'content': contenu};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], titre: map['title'], contenu: map['content']);
  }
}
