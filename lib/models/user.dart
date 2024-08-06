import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:uuid/uuid.dart';
import 'package:windbolt/models/friendship.dart';

class User {
  User({
    String? uuid,
    required this.name,
    String? tag,
    this.friends,
  })  : uuid = uuid ?? const Uuid().v4(),
        tag = tag ?? User.generateTag();

  String uuid;
  String name;
  String tag;
  List<Friendship>? friends;

  setName(String newName) {
    name = newName;
  }

  static String generateTag() {
    String tag = "";
    var rnd = math.Random();
    for (var i = 0; i < 4; i++) {
      tag = tag + rnd.nextInt(9).toString();
    }
    return tag;
  }

  Map<String, String?> toMap() {
    return {
      'uuid': uuid.toString(),
      'name': name,
      'tag': tag,
      'friends': friends != null ? friends!.fold('', (t, Friendship f) => "$t,${jsonEncode(f.toMap())}") : '',
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: map['uuid'],
      name: map['name'],
      tag: map['tag'],
      friends: map['friends'] != "null" ? List.from(jsonDecode(map['friends'])) : [],
    );
  }

  bool isFriendsWith(String userUuid) {
    if (friends == null) {
      return false;
    }
    for (var friend in friends!) {
      if (friend.userUuid == userUuid) {
        return true;
      }
    }
    return false;
  }

  removeFriend(String userUuid) {
    try {
      friends?.removeAt(friends!.indexWhere((friend) => friend.userUuid == userUuid));
    } catch (e) {
      log(e.toString());
    }
  }

  addFriend(String userUuid) {
    try {
      friends ??= [];
      friends?.add(Friendship(userUuid: userUuid));
    } catch (e) {
      log(e.toString());
    }
  }
}
