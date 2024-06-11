import 'package:windbolt/models/friend.dart';

class User {
  User({
    required this.id,
    required this.name,
  });

  int id;
  String name;
  List<Friendship> friends = [];

  setName(String newName) {
    name = newName;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id']?.toInt(), name: map['name'] ?? ('guest-${map['id']}'));
  }

  bool isFriendsWith(int userId) {
    for (var friend in friends) {
      if (friend.userId == userId) {
        return true;
      }
    }
    return false;
  }

  removeFriend(int userId) {
    try {
      friends.removeAt(friends.indexWhere((friend) => friend.userId == userId));
    } catch (e) {
      print(e);
    }
  }

  addFriend(int userId) {
    try {
      friends.add(Friendship(userId: userId));
    } catch (e) {
      print(e);
    }
  }
}
