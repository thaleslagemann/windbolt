import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  NumberFormat formatter = NumberFormat("0000");
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
                for (User user in globals.users.where((gu) => globals.user!.isFriendsWith(gu.id)))
                  if (user != globals.user)
                    CustomListTile(
                      title: user.name,
                      subtitle: "#${formatter.format(user.id)}",
                      leadingIcon: Icon(
                        Icons.handshake,
                        color: Colors.lightGreen[300],
                      ),
                      isIconButton: true,
                      onIconButtonPress: () {
                        globals.user!.isFriendsWith(user.id)
                            ? setState(() {
                                globals.user!.removeFriend(user.id);
                              })
                            : setState(() {
                                globals.user!.addFriend(user.id);
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: TextFormField(
                controller: addSearchController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Search for name and #tag',
                ),
                onChanged: (value) => _onSearchChanged(addSearchController.text),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (User user in filteredList.where((gu) => !globals.user!.isFriendsWith(gu.id)))
                  if (user != globals.user)
                    CustomListTile(
                      title: user.name,
                      subtitle: "#${formatter.format(user.id)}",
                      leadingIcon: const Icon(Icons.front_hand),
                      isIconButton: true,
                      onIconButtonPress: () {
                        globals.user!.isFriendsWith(user.id)
                            ? setState(() {
                                globals.user!.removeFriend(user.id);
                              })
                            : setState(() {
                                globals.user!.addFriend(user.id);
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

    for (User user in globals.users.where((user) => !globals.user!.isFriendsWith(user.id))) {
      if ((user.name.contains(finalName)) || (finalTag != null ? "#${formatter.format(user.id)}".contains(finalTag) : false)) {
        list.add(user);
      }
    }

    return list;
  }
}
