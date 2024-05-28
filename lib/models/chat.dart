import 'package:fgchat/models/message.dart';

class Chat {
  Chat({required this.type, this.title, required this.userIds, required this.messages}) : assert(userIds.isNotEmpty, 'Must have at least one id');

  ChatType type;
  String? title;
  List<int> userIds;
  List<Message> messages;

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
  groupDialogue,
}
