import 'package:windbolt/components/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WindBolt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen, brightness: Brightness.dark),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.lightGreen[300],
          selectionColor: Colors.lightGreen[300],
          selectionHandleColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
