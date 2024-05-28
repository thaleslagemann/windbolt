import 'package:windbolt/components/chat_screen.dart';
import 'package:windbolt/components/ui/custom_drawer.dart';
import 'package:windbolt/components/ui/drawer_list_tile.dart';
import 'package:windbolt/models/chat.dart';
import 'package:windbolt/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.user});

  final User? user;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Chat> chatList = [
    Chat(type: ChatType.monologue, userIds: [1], title: "My Monologue", messages: [])
  ];

  _openMenuBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      shape: const LinearBorder(),
      builder: (_) => Wrap(
        children: [
          DrawerListTile(
            title: "New chat",
            icon: const Icon(Icons.chat_sharp),
            onTap: () {},
          ),
          DrawerListTile(
            title: "New group",
            icon: const Icon(Icons.group_add_sharp),
            onTap: () {},
          ),
          DrawerListTile(
            title: "Find group",
            icon: const Icon(Icons.search),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !mounted
        ? CircularProgressIndicator()
        : Scaffold(
            endDrawer: const CustomDrawer(),
            body: Stack(
              children: [
                chatList.isEmpty
                    ? const Center(
                        child: Text("Welcome"),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ListView.builder(
                            itemCount: chatList.length,
                            itemBuilder: (context, value) {
                              return DrawerListTile(
                                title: chatList[value].title!,
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
                              );
                            }),
                      ),
                Positioned(
                  bottom: 0,
                  right: 3,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.black,
                    ),
                    child: IconButton(icon: const Icon(Icons.menu), onPressed: _openMenuBottomSheet),
                  ),
                ),
              ],
            ),
          );
  }
}
