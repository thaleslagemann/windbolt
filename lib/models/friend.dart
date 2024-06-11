import 'package:windbolt/globals.dart' as globals;

class Friendship {
  final int userId;
  final DateTime initDate;

  Friendship({required this.userId}) : initDate = DateTime.now();
}
