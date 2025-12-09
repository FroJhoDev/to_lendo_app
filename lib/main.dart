import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

void main() {
  runApp(const MyApp());
}

/// {@template my_app}
/// The main application widget.
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro my_app}
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tô Lendo',
      theme: AppTheme.theme,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
        '/book-details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return BookDetailsPage(book: args as Map<String, dynamic>?);
        },
        '/profile': (context) => const ProfilePage(),
        '/statistics': (context) => const StatisticsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
