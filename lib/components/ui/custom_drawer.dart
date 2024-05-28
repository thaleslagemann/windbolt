import 'package:windbolt/components/ui/drawer_list_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.67,
      child: ListView(
        children: [
          const DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 61, 131, 236),
            ),
            curve: Curves.easeIn,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Logged in as"),
                  Text(
                    "thales",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          DrawerListTile(
            title: "Chats",
            onTap: () => print("Chats"),
          ),
          DrawerListTile(
            title: "My groups",
            onTap: () => print("My groups"),
          ),
          DrawerListTile(
            title: "Discover",
            onTap: () => print("Discover"),
          ),
          DrawerListTile(
            title: "Account",
            onTap: () => print("Account"),
          ),
          DrawerListTile(
            title: "Settings",
            onTap: () => print("Settings"),
          ),
        ],
      ),
    );
  }
}
