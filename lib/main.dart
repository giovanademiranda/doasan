import 'package:doasan/pages/add_campaign_page.dart';
import 'package:doasan/pages/home_page.dart';
import 'package:doasan/pages/login_page.dart';
import 'package:doasan/pages/logo_page.dart';
import 'package:doasan/pages/notification_page.dart';
import 'package:doasan/pages/profile_page.dart';
import 'package:doasan/pages/signup_page.dart';
import 'package:doasan/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/user_model.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doasan',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3737)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/logo': (context) => const LogoPage(),
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const SignupPage(),
        '/home': (context) => const HomePage(userType: 'user'),
        '/admin_home': (context) => const HomePage(userType: 'admin'),
        '/add_campaign': (context) => const AddCampaignPage(),
        '/notifications': (context) => const NotificationsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/profile') {
          final user = settings.arguments as User?;
          return MaterialPageRoute(
            builder: (context) => ProfilePage(user: user!),
          );
        }
        return null;
      },
    );
  }
}
