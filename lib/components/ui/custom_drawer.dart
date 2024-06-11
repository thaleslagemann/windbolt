import 'package:windbolt/components/friends.dart';
import 'package:windbolt/components/home.dart';
import 'package:windbolt/components/login.dart';
import 'package:windbolt/components/ui/custom_list_tile.dart';
import 'package:windbolt/components/ui/custom_text.dart';
import 'package:windbolt/globals.dart' as globals;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.lightGreen[700]!,
                        Colors.lightGreen[600]!,
                        Colors.lightGreen[300]!,
                      ],
                    ),
                    // color: Color.fromARGB(255, 61, 131, 236),
                  ),
                  curve: Curves.easeIn,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome,",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            letterSpacing: -0.2,
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          globals.user!.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomListTile(
                  title: "Chats",
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        user: globals.user,
                      ),
                    ),
                  ),
                ),
                CustomListTile(
                  title: "Groups",
                  onTap: () => print("Groups"),
                ),
                CustomListTile(
                  title: "Friends",
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Friends(),
                    ),
                  ),
                ),
                CustomListTile(
                  title: "Discover",
                  onTap: () => print("Discover"),
                ),
                CustomListTile(
                  title: "Account",
                  onTap: () => print("Account"),
                ),
                CustomListTile(
                  title: "Settings",
                  onTap: () => print("Settings"),
                ),
                CustomListTile(
                  title: "Logout",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                    globals.isLoggedIn = false;
                    globals.user = null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
            child: CustomText(
              "WindBolt ${globals.version} 2024",
              style: TextStyle(
                fontSize: 8,
                color: Colors.lightGreen[100]!.withAlpha(75),
              ),
            ),
          )
        ],
      ),
    );
  }
}
