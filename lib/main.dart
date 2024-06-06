import 'package:doasan/pages/add_campaign_page.dart';
import 'package:doasan/pages/home_admin_page.dart';
import 'package:doasan/pages/home_page.dart';
import 'package:doasan/pages/login_page.dart';
import 'package:doasan/pages/logo_page.dart';
import 'package:doasan/pages/notification_page.dart';
import 'package:doasan/pages/reports_page.dart';
import 'package:doasan/pages/schedule_page.dart';
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
        '/add_campaign': (context) => const AddCampaignPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/reports': (context) => const ReportsPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            final args = settings.arguments as Map<String, dynamic>?;
            final user = args?['user'] as User?;
            return MaterialPageRoute(
              builder: (_) => HomePage(user: user!),
            );
          case '/home_admin':
            final args = settings.arguments as Map<String, dynamic>?;
            final user = args?['user'] as User?;
            return MaterialPageRoute(
              builder: (_) => HomeAdminPage(user: user!),
            );
          case '/schedule':
            final args = settings.arguments as Map<String, dynamic>?;
            final doadorId = args?['doadorId'] as String?;
            return MaterialPageRoute(
              builder: (_) => ScheduleScreen(doadorId: doadorId!),
            );
          default:
            return _errorRoute();
        }
      },
    );
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Erro'),
          ),
          body: const Center(
            child: Text('Rota não encontrada!'),
          ),
        );
      },
    );
  }
}
