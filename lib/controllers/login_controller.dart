import 'package:windbolt/models/user.dart';
import 'package:windbolt/globals.dart' as globals;

class LoginController {
  User? user;
  bool isLoggedIn = false;

  login(String user, String pass) {
    if (user == 'teste' && pass == '1234') {
      this.user = User(id: 1, name: "thales");
      isLoggedIn = true;
      globals.isLoggedIn = true;
      globals.user = User(id: 1, name: "thales");
    }
  }
}
