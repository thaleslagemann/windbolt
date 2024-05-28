import 'package:windbolt/models/chat.dart';
import 'package:windbolt/models/message.dart';

class ChatController {
  ChatController();
  late Chat chat;

  void send(Message message) {
    chat.messages.add(message);
  }
}
