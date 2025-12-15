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
    return MaterialApp.router(
      title: 'Tô Lendo',
      theme: AppTheme.theme,
      routerConfig: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
