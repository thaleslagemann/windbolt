class User {
  User({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  setName(String newName) {
    name = newName;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id']?.toInt(), name: map['name'] ?? ('guest-${map['id']}'));
  }
}
