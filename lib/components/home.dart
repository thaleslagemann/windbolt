import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:windbolt/components/chat_screen.dart';
import 'package:windbolt/components/ui/custom_app_bar.dart';
import 'package:windbolt/components/ui/custom_drawer.dart';
import 'package:windbolt/components/ui/custom_list_tile.dart';
import 'package:windbolt/components/ui/custom_text.dart';
import 'package:windbolt/models/chat.dart';
import 'package:windbolt/models/user.dart';
import 'package:flutter/material.dart';

import 'package:windbolt/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({super.key, required this.user});

  final User? user;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  List<Chat> chatList = [];
  late AnimationController animationController;
  NumberFormat formatter = NumberFormat("0000");

  @override
  initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 300);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !mounted
        ? const CircularProgressIndicator()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            endDrawer: const CustomDrawer(),
            appBar: const CustomAppBar(
              title: "Chats",
              leading: Icon(
                Icons.chat_sharp,
                size: 32,
              ),
              actions: [],
            ),
            body: Stack(
              children: [
                chatList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Welcome to ",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    letterSpacing: -1,
                                    fontSize: 28,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "WindBolt",
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Caveat",
                                        fontSize: 32,
                                        color: Colors.lightGreen[300],
                                      ),
                                    ),
                                    const TextSpan(text: ' !'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "To get started, create a new monologue by pressing the bottom-right options button and selecting ",
                                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, height: 1.5),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.chat_sharp,
                                        size: 16,
                                        color: Colors.lightGreen[300],
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' New Chat',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Colors.lightGreen[300],
                                      ),
                                    ),
                                    const TextSpan(
                                        text: ' !',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: chatList.length,
                        itemBuilder: (context, value) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                            child: CustomListTile(
                              title: chatList[value].title!,
                              decoration: BoxDecoration(border: Border.all(color: Colors.lightGreen[200]!), borderRadius: BorderRadius.circular(16)),
                              inkWellBorderRadius: BorderRadius.circular(16),
                              trailingIcon: chatList[value].type == ChatType.monologue ? const Icon(Icons.person) : const Icon(Icons.group),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      chat: chatList[value],
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                _openChatOptions(chatList[value]);
                              },
                            ),
                          );
                        }),
                Positioned(
                  bottom: 0,
                  right: 3,
                  child: Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                      ),
                      color: Colors.lightGreen[300],
                    ),
                    child: IconButton(
                        icon: Icon(
                          Icons.add_comment_sharp,
                          color: Colors.grey[900],
                        ),
                        onPressed: _openMenuBottomSheet),
                  ),
                ),
              ],
            ),
          );
  }

  _openNewChatModalBottomSheet() {
    double screenSize = MediaQuery.of(context).size.height;
    ChatType newChatType = ChatType.monologue;
    TextEditingController nameController = TextEditingController();
    List<String> newChatIdList = [globals.user!.uuid];
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      shape: const LinearBorder(),
      enableDrag: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: StatefulBuilder(builder: (context, setter) {
          return Wrap(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24.0, left: 30.0),
                    child: CustomText(
                      "New Chat",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Chat name"),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setter(() {
                          newChatType = ChatType.monologue;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: ChatType.monologue,
                            groupValue: newChatType,
                            visualDensity: VisualDensity.compact,
                            onChanged: (ChatType? value) {
                              setter(() {
                                newChatType = value!;
                              });
                            },
                          ),
                          const CustomText('Monologue'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setter(() {
                          newChatType = ChatType.dialogue;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: ChatType.dialogue,
                            groupValue: newChatType,
                            visualDensity: VisualDensity.compact,
                            onChanged: (ChatType? value) {
                              setter(() {
                                newChatType = value!;
                              });
                            },
                          ),
                          const CustomText('Dialogue'),
                        ],
                      ),
                    ),
                    newChatType == ChatType.dialogue
                        ? Column(
                            children: [
                              const CustomText("Select friends:"),
                              globals.user!.friends!.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(
                                        "You should add some friends before making a group",
                                        textColor: Colors.lightGreen[200]!.withAlpha(100),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox(
                                      height: screenSize * 0.2,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          for (User user in globals.users.where((u) => globals.user!.isFriendsWith(u.uuid)))
                                            CustomListTile(
                                              dense: true,
                                              title: user.name,
                                              subtitle: "#${user.tag}",
                                              leadingIcon: newChatIdList.contains(user.uuid)
                                                  ? Icon(
                                                      Icons.check_box,
                                                      color: Colors.lightGreen[200]!,
                                                    )
                                                  : Icon(
                                                      Icons.check_box_outline_blank,
                                                      color: Colors.lightGreen[200]!,
                                                    ),
                                              isIconButton: true,
                                              onIconButtonPress: () {
                                                if (newChatIdList.contains(user.uuid)) {
                                                  setter(() {
                                                    newChatIdList.remove(user.uuid);
                                                  });
                                                } else {
                                                  setter(() {
                                                    newChatIdList.add(user.uuid);
                                                  });
                                                }
                                              },
                                            )
                                        ],
                                      ),
                                    ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (nameController.text == '') {
                        return;
                      }
                      if (newChatType == ChatType.dialogue && newChatIdList.length <= 1) {
                        return;
                      } else {
                        setState(() {
                          chatList.add(
                            Chat(
                              title: nameController.text,
                              type: newChatType,
                              userUuids: newChatIdList,
                              messages: [],
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: CustomText(
                      "ok",
                      textColor: Colors.lightGreen[400],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      "cancel",
                      textColor: Colors.lightBlue[100],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  _openMenuBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.lightGreen[300],
      context: context,
      shape: const LinearBorder(),
      enableDrag: true,
      transitionAnimationController: animationController,
      builder: (_) => Wrap(
        children: [
          CustomListTile(
            title: "New chat",
            textColor: Colors.grey[900],
            splashColor: Colors.lightGreen[200],
            leadingIcon: Icon(Icons.add_comment_sharp, color: Colors.grey[900]),
            onTap: () {
              _openNewChatModalBottomSheet();
            },
          ),
          CustomListTile(
            title: "Find group",
            textColor: Colors.grey[900],
            splashColor: Colors.lightGreen[200],
            leadingIcon: Icon(Symbols.search_sharp, weight: 900, color: Colors.grey[900]),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _renameChatMBS(Chat chat) {
    TextEditingController renameController = TextEditingController(text: chat.title);
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

  _viewParticipantsMBS(Chat chat) {
    showModalBottomSheet(
      context: context,
      shape: const LinearBorder(),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText("Chat participants"),
                ),
                for (var user in globals.users.where((user) => chat.userUuids.contains(user.uuid)))
                  CustomListTile(
                    trailingIcon: user.uuid == globals.users.where((user) => chat.userUuids.contains(user.uuid)).first.uuid
                        ? Icon(
                            Icons.shield,
                            color: Colors.lightGreen[300]!,
                          )
                        : const Icon(Icons.shield_outlined),
                    title: user.name,
                    subtitle: "#${user.tag}",
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _openChatOptions(Chat chat) {
    showMenu(context: context, position: const RelativeRect.fromLTRB(100, 100, 100, 100), items: [
      PopupMenuItem(
        child: const CustomText("Rename Chat"),
        onTap: () {
          _renameChatMBS(chat);
        },
      ),
      PopupMenuItem(
        child: const CustomText("View Participants"),
        onTap: () {
          _viewParticipantsMBS(chat);
        },
      ),
      PopupMenuItem(
        child: const CustomText("Delete Chat"),
        onTap: () {
          _deleteChatMBS(chat);
        },
      ),
    ]);
  }

  _deleteChatMBS(Chat chat) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        "Delete Chat?",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                chatList.remove(chat);
                              });
                              Navigator.of(context).pop();
                            },
                            child: const CustomText(
                              "delete",
                              textColor: Colors.red,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
