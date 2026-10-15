import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

/// Route names and the route table, kept in one place
/// so names are never mistyped across files.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String login = '/login';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
