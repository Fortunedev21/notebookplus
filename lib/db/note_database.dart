import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';
import '../models/utilisateur.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'note_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE utilisateurs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            userId INTEGER,
            FOREIGN KEY(userId) REFERENCES utilisateurs(id)
          )
        ''');
      },
    );
  }

  Future<int> insertUser(Utilisateur user) async {
    final db = await database;
    return await db.insert('utilisateurs', user.toMap());
  }

  Future<Utilisateur?> getUser(String username, String password) async {
    final db = await database;
    final maps = await db.query(
      'utilisateurs',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) return Utilisateur.fromMap(maps.first);
    return null;
  }

  Future<int> insertNote(Note note, int userId) async {
    final db = await database;
    var map = note.toMap();
    map['userId'] = userId;
    return await db.insert('notes', map);
  }

  Future<List<Note>> getNotes(int userId) async {
    final db = await database;
    final maps = await db.query(
      'notes',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
