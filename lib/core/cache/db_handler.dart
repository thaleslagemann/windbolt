import 'dart:convert';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:windbolt/globals.dart' as globals;
import 'package:windbolt/models/user.dart';

class DBHandler {
  Database? db;

  Future<Database> open(String dbPath) async {
    try {
      final database = await openDatabase(dbPath);
      if (database.isOpen) {
        db = database;
        return database;
      }
    } catch (e) {
      log(e.toString());
    }
    throw (DatabaseException);
  }

  close() {
    if (db != null && db!.isOpen) {
      db!.close();
    }
  }

  clean() {
    if (db != null) {
      db!.delete('users');
    }
  }

  Future<void> createTables() async {
    if (db != null && db!.isOpen) {
      await db!.execute('''
      CREATE TABLE IF NOT EXISTS users(
        uuid TEXT PRIMARY KEY,
        tag TEXT NOT NULL,
        name TEXT NOT NULL,
        friends TEXT DEFAULT '',
        creationDate TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
      await db!.execute('''
      CREATE TABLE IF NOT EXISTS chats(
        uuid TEXT PRIMARY KEY,
        tag TEXT NOT NULL,
        name TEXT NOT NULL,
        friends TEXT DEFAULT '',
        creationDate TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
      await db!.execute('''
      CREATE TABLE IF NOT EXISTS operations(
        uuid TEXT PRIMARY KEY,
        tag TEXT NOT NULL,
        name TEXT NOT NULL,
        friends TEXT DEFAULT '',
        creationDate TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    }
  }

  Future<int?> insertData() async {
    int count = 0;
    for (var user in globals.usersMocado) {
      if (db != null && db!.isOpen) {
        try {
          await db!.insert(
            'users',
            {
              'uuid': user.uuid,
              'tag': user.tag,
              'name': user.name,
              'friends': jsonEncode(user.friends),
              'creationDate': DateTime.now().toIso8601String(),
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          count++;
          log("inserted ${user.name}");
        } catch (e) {
          log(e.toString());
          continue;
        }
      }
    }
    return count;
  }

  Future<List<Map<String, Object?>>?> test() async {
    if (db == null) {
      return Future.value(null);
    }
    try {
      final List<Map<String, Object?>> response = await db!.query('users');
      if (response.isEmpty) {
        return Future.value(null);
      }
      for (var aux in response) {
        globals.users.add(User.fromMap(aux));
      }
      return response;
    } catch (e) {
      log(e.toString());
    }
    return Future.value(null);
  }

  Future<int?> insert(String table, Map<String, Object?> data) async {
    if (db == null || db?.isOpen == false) {
      await open("${await getDatabasesPath()}/localStorage.db");
    }
    try {
      final i = await db?.insert(table, data);
      return i;
    } catch (e) {
      log(e.toString());
      return Future.value(null);
    }
  }
}
