import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({super.key, required this.title, this.icon, this.onTap});

  final String title;
  final Icon? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 49, 59, 73),
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: ListTile(
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
