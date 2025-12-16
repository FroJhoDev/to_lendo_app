import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// App initialization
Future<void> initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize Supabase
  await Supabase.initialize(url: SupabaseConstants.supabaseUrl, anonKey: SupabaseConstants.supabaseAnonKey);

  // Initialize dependency injection
  await initInjection();

  // Check first open status before building the app
  await injection<RedirectService>().checkFirstOpen();

  runApp(const App());
}
