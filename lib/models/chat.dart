import 'package:windbolt/models/message.dart';

class Chat {
  ChatType type;
  String? title;
  List<int> userIds;
  List<Message> messages;
  Chat({
    required this.type,
    this.title,
    required this.userIds,
    required this.messages,
  }) : assert(userIds.isNotEmpty, 'Must have at least one id');

  String typeString() {
    return type == ChatType.dialogue ? "dialogue" : "monologue";
  }

  addMessage(Message message) {
    messages.add(message);
  }

  List<Message> getChatHistory() {
    return messages;
  }
}

enum ChatType {
  monologue,
  dialogue,
}
