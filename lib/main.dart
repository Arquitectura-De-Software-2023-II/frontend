import 'package:flutter/material.dart';
import 'package:mypetcare/pages/home.dart';
import 'package:mypetcare/pages/login.dart';
import 'package:mypetcare/pages/principal.dart';
import 'package:mypetcare/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String principal = '/principal';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyPetCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const PrincipalPage(),
      routes: {
        Routes.home: (context) => MyHomePage(),
        Routes.login:(context) => const LoginPage(),
        Routes.register: (context) => const RegisterPage(),
        Routes.principal:(context) => const PrincipalPage()
      },
    );
  }
}