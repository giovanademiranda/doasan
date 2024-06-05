import 'package:doasan/data/user_model.dart';
import 'package:doasan/pages/add_campaign_page.dart';
import 'package:doasan/pages/home_page.dart';
import 'package:doasan/pages/login_page.dart';
import 'package:doasan/pages/logo_page.dart';
import 'package:doasan/pages/notification_page.dart';
import 'package:doasan/pages/profile_page.dart';
import 'package:doasan/pages/reports_page.dart';
import 'package:doasan/pages/signup_page.dart';
import 'package:doasan/pages/splash_screen.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/logo':
            return MaterialPageRoute(builder: (_) => const LogoPage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/cadastro':
            return MaterialPageRoute(builder: (_) => const SignupPage());
          case '/home':
            final args = settings.arguments as Map<String, dynamic>?;
            final userType = args?['userType'] as String?;
            return MaterialPageRoute(
              builder: (_) => HomePage(
                userType: userType ?? '',
              ),
            );
          case '/home_admin':
            return MaterialPageRoute(
              builder: (_) => const HomePage(
                userType: 'admin',
              ),
            );
          case '/add_campaign':
            return MaterialPageRoute(builder: (_) => const AddCampaignPage());
          case '/notifications':
            return MaterialPageRoute(
              builder: (_) => const NotificationsPage(),
            );
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null) {
              final user = args['user'] as User;
              return MaterialPageRoute(
                builder: (_) => ProfilePage(user: user),
              );
            }
            return _errorRoute();
          case '/relatorios':
            return MaterialPageRoute(builder: (_) => const ReportsPage());
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
