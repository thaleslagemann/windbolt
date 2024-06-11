import 'package:windbolt/models/user.dart';
import 'package:windbolt/globals.dart' as globals;

class LoginController {
  User? user;
  bool isLoggedIn = false;

  bool login(String username, String pass) {
    for (var user in globals.users) {
      if (username == user.name) {
        this.user = user;
        isLoggedIn = true;
        globals.isLoggedIn = true;
        globals.user = user;
        return true;
      }
    }
    return false;
  }
}
