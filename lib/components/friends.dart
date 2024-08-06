import 'dart:async';

import 'package:flutter/material.dart';
import 'package:windbolt/components/ui/custom_app_bar.dart';
import 'package:windbolt/components/ui/custom_drawer.dart';
import 'package:windbolt/components/ui/custom_list_tile.dart';
import 'package:windbolt/components/ui/custom_text.dart';
import 'package:windbolt/models/user.dart';
import 'package:windbolt/globals.dart' as globals;

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<User> filteredList = globals.users;
  TextEditingController addSearchController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Friends",
        leading: Icon(
          Icons.person_pin_circle_sharp,
          size: 32,
        ),
      ),
      endDrawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CustomText("My friends"),
          ),
          Expanded(
            child: ListView(
              children: [
                for (User user in globals.users.where((gu) => globals.user!.isFriendsWith(gu.uuid)))
                  if (user != globals.user)
                    CustomListTile(
                      title: user.name,
                      subtitle: "#${user.tag}",
                      leadingIcon: Icon(
                        Icons.handshake,
                        color: Colors.lightGreen[300],
                      ),
                      isIconButton: true,
                      onIconButtonPress: () {
                        globals.user!.isFriendsWith(user.uuid)
                            ? setState(() {
                                globals.user!.removeFriend(user.uuid);
                              })
                            : setState(() {
                                globals.user!.addFriend(user.uuid);
                              });
                      },
                    )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CustomText("Add a friend"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: TextFormField(
                controller: addSearchController,
                decoration:
                    const InputDecoration(label: CustomText('Search for name and #tag'), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
                onChanged: (value) => _onSearchChanged(addSearchController.text),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (User user in filteredList.where((gu) => !globals.user!.isFriendsWith(gu.uuid)))
                  if (user != globals.user)
                    CustomListTile(
                      title: user.name,
                      subtitle: "#${user.tag}",
                      leadingIcon: const Icon(Icons.front_hand),
                      isIconButton: true,
                      onIconButtonPress: () {
                        globals.user!.isFriendsWith(user.uuid)
                            ? setState(() {
                                globals.user!.removeFriend(user.uuid);
                              })
                            : setState(() {
                                globals.user!.addFriend(user.uuid);
                              });
                      },
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onSearchChanged(String text) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (text != '') {
        setState(() {
          filteredList = filterUsers(text);
        });
      } else {
        setState(() {
          filteredList = globals.users;
        });
      }
    });
  }

  List<User> filterUsers(String filterInput) {
    final finalInput = filterInput.trim().split('#');
    late final String? finalTag;
    late final String? finalName;
    if (finalInput.length > 1) {
      finalName = finalInput.getRange(0, finalInput.length - 1).join(" ");
      finalTag = "#${finalInput.last}";
    } else {
      finalTag = null;
      finalName = finalInput.join(" ");
    }
    List<User> list = [];

    for (User user in globals.users.where((user) => !globals.user!.isFriendsWith(user.uuid))) {
      if ((user.name.contains(finalName)) || (finalTag != null ? "#${user.tag}".contains(finalTag) : false)) {
        list.add(user);
      }
    }

    return list;
  }
}
