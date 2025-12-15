import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:to_lendo_app/src/injections.dart';
import 'package:to_lendo_app/src/src.dart';

/// App initialization
Future<void> initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize dependency injection
  await initInjection();

  // Check first open status before building the app
  await injection<RedirectService>().checkFirstOpen();

  runApp(const App());
}
