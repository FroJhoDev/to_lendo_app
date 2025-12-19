import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template my_app}
/// The main application widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro my_app}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    for (final path in AppImages.imagesList) {
      precacheImage(AssetImage(path), context);
    }

    for (final path in AppAnimations.animationsList) {
      precacheImage(AssetImage(path), context);
    }

    return MaterialApp.router(
      title: 'Tô Lendo',
      theme: AppTheme.theme,
      routerConfig: AppRoute.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
