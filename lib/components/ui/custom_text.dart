import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.data, {
    this.style,
    this.textColor,
    this.textAlign,
    super.key,
  });

  final String data;
  final TextStyle? style;
  final Color? textColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style ??
          TextStyle(
            color: textColor ?? Colors.white,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      textAlign: textAlign,
    );
  }
}
