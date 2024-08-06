import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:windbolt/core/cache/operation.dart';
import 'package:windbolt/core/cache/operation_controller.dart';

class OperationService {
  OperationController controller = OperationController();

  Future<http.Response>? request(Operation? operation) {
    if (operation == null) {
      return null;
    }
    if (operation.endpoint == null || operation.endpoint!.isEmpty) {
      return null;
    }
    if (operation.method == null || operation.method == '' || operation.method == 'GET') {
      return http.get(Uri.parse(operation.endpoint!));
    }
    if (operation.method == 'POST' && operation.data != null && operation.data!.isNotEmpty) {
      return http.post(
        Uri.parse(operation.endpoint!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(operation.data),
      );
    } else {
      return null;
    }
  }
}
