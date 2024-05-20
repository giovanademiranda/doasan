import 'package:doasan/screens/login_page.dart';
import 'package:doasan/screens/logo_page.dart';
import 'package:doasan/screens/signup_page.dart';
import 'package:doasan/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doasan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3737)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/logo': (context) => const LogoPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const SignupPage(),
      },
    );
  }
}
