import 'package:windbolt/components/home.dart';
import 'package:windbolt/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  LoginController controller = LoginController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _login(String username, String password) {
    print("tentou logar");
    controller.login(username, password);
    if (controller.isLoggedIn && controller.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(user: controller.user),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 250,
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      "WindBolt",
                      style: TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 1,
                    child: Text(
                      "WindBolt",
                      style: TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 61, 131, 236),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(hintText: "username"),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _login(
                usernameController.text.trim(),
                passwordController.text.trim(),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 61, 131, 236),
              ),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
