import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:windbolt/components/login.dart';
import 'package:flutter/material.dart';
import 'package:windbolt/core/cache/db_handler.dart';
import 'package:windbolt/globals.dart' as globals;

_dbStartup(DBHandler db) async {
  log("trying to open db at path: ${"${await getDatabasesPath()}/localStorage.db"}");
  await db.open("${await getDatabasesPath()}/localStorage.db");
  log("db opened ${db.db?.path}");
  log("testing");
  await globals.userService.postUser(globals.usersMocado.first);
  final aux = await globals.userService.getUsers();
  if (aux != null) {
    globals.users = aux;
    for (var user in globals.users) {
      log(user.name);
    }
    log("success");
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBHandler db = globals.dbHandler;
  _dbStartup(db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WindBolt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen[400]!, brightness: Brightness.dark),
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
