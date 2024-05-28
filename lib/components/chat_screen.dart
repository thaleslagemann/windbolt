import 'package:fgchat/components/ui/custom_app_bar.dart';
import 'package:fgchat/components/ui/custom_drawer.dart';
import 'package:fgchat/models/chat.dart';
import 'package:fgchat/models/message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (Message msg in widget.chat.messages)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Text(msg.content),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _messageController,
                decoration: InputDecoration(border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
