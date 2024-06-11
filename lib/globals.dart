library windbolt.globals;

import 'package:windbolt/models/user.dart';

bool isLoggedIn = false;
User? user;

String version = "v0.0.1";

List<User> users = [
  User(id: 1, name: "Thales"),
  User(id: 2, name: "Mari"),
  User(id: 3, name: "Athos"),
  User(id: 4, name: "Moby Dick"),
  User(id: 5, name: "Ronald Reagan"),
  User(id: 6, name: "Robinho"),
  User(id: 7, name: "Monty Python"),
];
