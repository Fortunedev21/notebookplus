class Utilisateur {
  final int? id;
  final String username;
  final String password;

  Utilisateur({this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'password': password};
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}
