import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:windbolt/components/ui/custom_app_bar.dart';
import 'package:windbolt/components/ui/custom_drawer.dart';
import 'package:windbolt/controllers/chat_controller.dart';
import 'package:windbolt/models/chat.dart';
import 'package:windbolt/models/message.dart';
import 'package:flutter/material.dart';
import 'package:windbolt/globals.dart' as globals;

import 'ui/custom_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController controller = ChatController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _showScrollDownIcon = false;

  _sendMessage(String messageBody) {
    Message messageAux = Message(
      senderId: 1,
      receiverIds: controller.chat.userIds.length > 1 ? controller.chat.userIds : null,
      content: messageBody,
      timestamp: DateTime.now(),
    );
    setState(() {
      controller.send(messageAux);
      _messageController.clear();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.hasContentDimensions) {
      if (_scrollController.offset > 20.0) {
        if (_showScrollDownIcon == false) {
          setState(() {
            _showScrollDownIcon = true;
          });
        }
      } else {
        if (_showScrollDownIcon == true) {
          setState(() {
            _showScrollDownIcon = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    controller.chat = widget.chat;
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _clickMsg(Message msg) {
    Message? msgAux = widget.chat.messages.where((element) => element.timestamp == msg.timestamp).firstOrNull;
    if (msgAux != null) {
      if (msgAux.received == true && msgAux.isVisualized == true) {
        setState(() {
          msgAux.setReceived = false;
          msgAux.setVisualized = false;
        });
        return;
      }
      if (msgAux.received == true && msgAux.isVisualized == false) {
        setState(() {
          msgAux.setVisualized = true;
        });
        return;
      }
      if (msgAux.received == false && msgAux.isVisualized == false) {
        setState(() {
          msgAux.setReceived = true;
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const CustomDrawer(),
      appBar: CustomAppBar(
        title: widget.chat.title,
        actions: [
          MenuAnchor(
              builder: (BuildContext context, MenuController controller, Widget? child) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Chat settings',
                );
              },
              menuChildren: [
                MenuItemButton(
                  child: const CustomText("Rename Chat"),
                  onPressed: () {
                    _renameChatMBS(widget.chat);
                  },
                ),
                const MenuItemButton(
                  child: CustomText("View Contact"),
                ),
                const MenuItemButton(
                  child: CustomText("Search"),
                ),
                const SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      child: CustomText("Block"),
                    ),
                    MenuItemButton(
                      child: CustomText("Report"),
                    ),
                  ],
                  child: CustomText("More"),
                ),
              ]),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(90),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText("This is the beggining of a great ${widget.chat.typeString()}!"),
                        ),
                      ),
                      for (Message msg in widget.chat.messages)
                        Align(
                          alignment: msg.senderId == globals.user!.id ? Alignment.centerRight : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: msg.senderId == globals.user!.id ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => _clickMsg(msg),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 2),
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                    child: Text(msg.content),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      msg.isVisualized
                                          ? Icons.visibility
                                          : msg.isReceived
                                              ? Icons.mail
                                              : Icons.cloud,
                                      size: 14,
                                      color: msg.isVisualized
                                          ? Colors.lightGreen[300]
                                          : msg.isReceived
                                              ? Colors.amber[200]
                                              : Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(DateFormat.Hm().format(msg.timestamp), style: const TextStyle(fontSize: 10)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: AnimatedOpacity(
                    opacity: _showScrollDownIcon ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 100),
                    curve: Easing.emphasizedAccelerate,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey[800]),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              _scrollController.jumpTo(0.0);
                            });
                          },
                          icon: const Icon(Icons.arrow_downward_rounded)),
                    ),
                  ),
                )
              ],
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
                      hintText: 'What\'s on your mind goes here...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
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
                  onPressed: () {
                    if (_messageController.text.trim() != '') {
                      _sendMessage(_messageController.text);
                    }
                  },
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

  _renameChatMBS(Chat chat) {
    TextEditingController renameController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const LinearBorder(),
      builder: (_) => Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 30.0),
                      child: Text(
                        "Rename Chat",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
                  child: TextFormField(
                    controller: renameController,
                    decoration: const InputDecoration(hintText: "new chat name"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          chat.title = renameController.text;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "ok",
                        style: TextStyle(color: Colors.lightGreen[300]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "cancel",
                        style: TextStyle(color: Colors.lightBlue[100]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
