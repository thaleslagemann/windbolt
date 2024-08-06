import 'dart:convert';
import 'dart:developer';

import 'package:windbolt/core/cache/db_handler.dart';
import 'package:windbolt/core/cache/operation.dart';
import 'package:windbolt/globals.dart' as globals;
import 'package:windbolt/models/operations/user.list.operation.dart';
import 'package:windbolt/models/operations/user.post.operation.dart';
import 'package:windbolt/models/user.dart';
import 'package:windbolt/services/operation_service.dart';

class UserService {
  DBHandler handler = globals.dbHandler;
  OperationService opService = OperationService();

  Future<List<User>?> getUsers() async {
    try {
      final operation = UserListOperation();
      final execution = await opService.controller.add(operation);

      if (execution != null && execution.status == OperationStatus.SUCCESS) {
        final aux = jsonDecode(execution.response);
        return aux;
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<void> postUser(User user) async {
    try {
      final operation = UserPostOperation(user: user);
      final execution = await opService.controller.add(operation);

      if (execution != null && execution.status == OperationStatus.SUCCESS) {
        final aux = jsonDecode(execution.response);
        return aux;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
