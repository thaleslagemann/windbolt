import 'package:fgchat/models/user.dart';

class LoginController {
  User? user;
  bool isLoggedIn = false;

  login(String user, String pass) {
    if (user == 'teste' && pass == '1234') {
      this.user = User(id: 1, name: "thales");
      isLoggedIn = true;
    }
  }
}
