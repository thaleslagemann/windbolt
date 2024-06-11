import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.dense = false,
    required this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.textColor,
    this.tileColor,
    this.splashColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.onLongPress,
    this.onIconButtonPress,
    this.isIconButton = false,
  });

  final bool dense;
  final String title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final bool isIconButton;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onIconButtonPress;
  final Color? tileColor;
  final Color? textColor;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor ?? Colors.lightGreen[200]?.withAlpha(100),
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      onLongPress: onLongPress,
      child: ListTile(
        dense: dense,
        leading: leadingIcon != null
            ? isIconButton
                ? IconButton(
                    onPressed: onIconButtonPress,
                    icon: leadingIcon!,
                    visualDensity: dense ? VisualDensity.compact : VisualDensity.standard,
                  )
                : leadingIcon
            : null,
        trailing: trailingIcon,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(title),
            const SizedBox(
              width: 10,
            ),
            Text(
              subtitle ?? "",
              style: subtitleTextStyle ??
                  const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: Colors.white54,
                  ),
            ),
          ],
        ),
        tileColor: tileColor,
        titleTextStyle: titleTextStyle ??
            const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
        textColor: textColor ?? Colors.grey[300],
      ),
    );
  }
}
