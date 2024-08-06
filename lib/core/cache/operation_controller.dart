import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:windbolt/core/cache/db_handler.dart';

import 'operation.dart';

class OperationController {
  DBHandler dbHandler = DBHandler();
  static const String tableName = "operations";
  final Map<String, Operation> _operations = HashMap();

  Future<T?> add<T extends Operation>(T operation) async {
    operation = await execute<T>(operation);

    await update(operation);

    return operation;
  }

  Future<T> execute<T extends Operation>(T operation) async {
    final execution = await operation.execute<T>();

    await update(operation);

    return execution;
  }

  Future<void> update(Operation operation) async {
    _operations[operation.slug] = operation;

    await save();
  }

  Future<void> save() async {
    await dbHandler.insert(tableName, _operations);
  }
}
