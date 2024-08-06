import 'dart:convert';

import 'package:windbolt/core/cache/operation.dart';
import 'package:windbolt/models/user.dart';

class UserPostOperation extends Operation {
  User user;

  UserPostOperation({
    super.uuid,
    super.response,
    super.status,
    super.timestamp,
    required User this.user,
  }) : super(
          method: 'POST',
          endpoint: 'http://10.0.2.2:3000/',
          name: 'users/new_user',
          slug: 'users/new_user',
          data: jsonEncode(user.toMap()),
        );

  @override
  get response {
    if (rawResponse == null) {
      throw Exception('Response is null');
    }

    return rawResponse!;
  }
}
