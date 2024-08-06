import 'package:windbolt/core/cache/operation.dart';

class UserListOperation extends Operation {
  UserListOperation({
    super.uuid,
    super.response,
    super.status,
    super.timestamp,
  }) : super(
          method: 'GET',
          endpoint: 'http://10.0.2.2:3000/',
          name: 'users/list_users',
          slug: 'users/list_users',
        );

  @override
  get response {
    if (rawResponse == null) {
      throw Exception('Response is null');
    }

    return rawResponse!;
  }
}
