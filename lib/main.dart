import 'package:doasan_pi/pages/add_post_page.dart';
import 'package:doasan_pi/pages/home_page.dart';
import 'package:doasan_pi/pages/login_page.dart';
import 'package:doasan_pi/pages/logo_page.dart';
import 'package:doasan_pi/pages/notifications_page.dart';
import 'package:doasan_pi/pages/profile_page.dart';
import 'package:doasan_pi/pages/report_page.dart';
import 'package:doasan_pi/pages/schedule_page.dart';
import 'package:doasan_pi/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

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
        '/': (context) => const LogoPage(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomeScreen(),
        '/schedule': (context) => const AppointmentScreen(),
        '/notifications': (context) => const NotificationsPage(),
        '/profile': (context) => const ProfileScreen(),
        '/add_post': (context) => const AddCampaignPage(),
        '/reports': (context) => const ReportScreen(),
      },
    );
  }
}
