import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleTextStyle,
    this.backgroundColor,
    this.surfaceTintColor,
    this.actions,
    this.leading,
  });

  final String? title;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      titleTextStyle: titleTextStyle ??
          const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
      backgroundColor: backgroundColor ?? Colors.black38,
      toolbarOpacity: 1,
      surfaceTintColor: surfaceTintColor ?? Colors.black38,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
