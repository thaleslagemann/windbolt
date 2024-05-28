import 'package:windbolt/components/ui/custom_app_bar.dart';
import 'package:windbolt/components/ui/custom_drawer.dart';
import 'package:windbolt/controllers/chat_controller.dart';
import 'package:windbolt/models/chat.dart';
import 'package:windbolt/models/message.dart';
import 'package:flutter/material.dart';
import 'package:windbolt/globals.dart' as globals;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController controller = ChatController();

  _sendMessage(String messageBody) {
    Message messageAux = Message(
      senderId: 1,
      receiverId: controller.chat.userIds.length > 1 ? controller.chat.userIds[1] : null,
      content: messageBody,
      timestamp: DateTime.now(),
    );
    setState(() {
      controller.send(messageAux);
    });
  }

  @override
  void initState() {
    controller.chat = widget.chat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: CustomAppBar(
        title: widget.chat.title,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  for (Message msg in widget.chat.messages)
                    Align(
                      alignment: msg.senderId == globals.user.id ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: msg.senderId == globals.user.id ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 5, right: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                            child: Text(msg.content),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('${msg.timestamp.hour.toString()}:${msg.timestamp.minute.toString()}', style: const TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    clipBehavior: Clip.hardEdge,
                    controller: _messageController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[800]?.withAlpha(200),
                      filled: true,
                      hintText: 'Message...',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton.small(
                  onPressed: () => _sendMessage(_messageController.text),
                  backgroundColor: Colors.grey[800],
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
