library windbolt.globals;

import 'package:windbolt/core/cache/db_handler.dart';
import 'package:windbolt/models/user.dart';
import 'package:windbolt/services/user_service.dart';

bool isLoggedIn = false;
User? user;

DBHandler dbHandler = DBHandler();
UserService userService = UserService();

String version = "v0.0.1";

List<User> users = [];

List<User> usersMocado = [
  User(name: "Thales"),
  User(name: "Mari"),
  User(name: "Athos"),
  User(name: "Moby Dick"),
  User(name: "Ronald Reagan"),
  User(name: "Robinho"),
  User(name: "Monty Python"),
];
