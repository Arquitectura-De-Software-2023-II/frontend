import 'package:flutter/material.dart';
import 'package:mypetcare/pages/create_pet.dart';
import 'package:mypetcare/pages/home.dart';
import 'package:mypetcare/pages/login.dart';
import 'package:mypetcare/pages/principal.dart';
import 'package:mypetcare/pages/register.dart';
import 'package:mypetcare/pages/maps.dart';
import 'package:mypetcare/pages/watch_news.dart';
import 'package:mypetcare/pages/watch_news_en.dart';
import 'package:mypetcare/pages/watch_pets.dart';
import 'package:mypetcare/pages/watch_doctors.dart';

void main() {
  runApp(const MyApp());
}

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String principal = '/principal';
  static const String maps = '/maps';
  static const String lookPets = '/mypets';
  static const String lookDoctors = '/doctors';
  static const String createPet = '/createPet';
  static const String news = '/news';
  static const String newsEn = '/newsEn';
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
        Routes.login: (context) => const LoginPage(),
        Routes.register: (context) => const RegisterPage(),
        Routes.principal: (context) => const PrincipalPage(),
        Routes.maps: (context) => const MapsPage(),
        Routes.lookPets: (context) => const WatchUserPets(),
        Routes.lookDoctors: (context) => const WatchDoctors(),
        Routes.createPet: (context) => const CreatePetPage(),
        Routes.news: (context) => const WatchNews(),
        Routes.newsEn: (context) => const WatchNewsEn(),
      },
    );
  }
}
