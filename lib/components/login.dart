import 'package:windbolt/components/home.dart';
import 'package:windbolt/components/ui/custom_text.dart';
import 'package:windbolt/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  LoginController controller = LoginController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _login(String username, String password) {
    print("tentou logar");
    bool logou = controller.login(username, password);
    if (logou) {
      if (controller.isLoggedIn && controller.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(user: controller.user),
          ),
        );
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      "WindBolt",
                      style: TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightGreen[100],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 1.5,
                    child: Text(
                      "WindBolt",
                      style: TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightGreen[400],
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
              decoration: InputDecoration(hintText: "username", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen[300]!))),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "password", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen[300]!))),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                bool logou = _login(usernameController.text.trim(), passwordController.text.trim());
                if (logou) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const CustomText(
                            "Logged in as ",
                            textColor: Colors.black,
                          ),
                          CustomText(
                            "${controller.user?.name}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.lightGreen[400],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const CustomText("Login failed"),
                      backgroundColor: Colors.red[300],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightGreen[400],
              ),
              child: const CustomText(
                "Login",
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
