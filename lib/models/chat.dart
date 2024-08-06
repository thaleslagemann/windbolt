import 'dart:convert';

import 'package:windbolt/models/message.dart';

class Chat {
  ChatType type;
  String? title;
  List<String> userUuids;
  List<Message> messages;
  Chat({
    required this.type,
    this.title,
    required this.userUuids,
    required this.messages,
  }) : assert(userUuids.isNotEmpty, 'Must have at least one id');

  String typeString() {
    return type == ChatType.dialogue ? "dialogue" : "monologue";
  }

  addMessage(Message message) {
    messages.add(message);
  }

  List<Message> getChatHistory() {
    return messages;
  }

  Map<String, String?> toMap() {
    return {
      'type': type.name,
      'title': title,
      'userUuids': jsonEncode(userUuids),
      'messages': jsonEncode(messages),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      type: jsonDecode(map['userUuids']).length > 1 ? ChatType.dialogue : ChatType.monologue,
      title: map['title'],
      userUuids: jsonDecode(map['userUuids']),
      messages: jsonDecode(map['messages']),
    );
  }
}

enum ChatType {
  monologue,
  dialogue,
}
