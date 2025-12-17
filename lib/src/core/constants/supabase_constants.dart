import 'package:packages/packages.dart';

/// {@template supabase_constants}
/// Constants for Supabase configuration.
/// {@endtemplate}
sealed class SupabaseConstants {
  SupabaseConstants._();

  /// Supabase project URL
  ///
  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('SUPABASE_URL is not set in .env file');
    }
    return url;
  }

  /// Supabase anonymous/public key
  ///
  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY is not set in .env file');
    }
    return key;
  }

  // Tables names (to be used when implementing database features)
  // static const String booksTable = 'books';
  // static const String readingSessionsTable = 'reading_sessions';
  // static const String usersTable = 'users';

  // Storage buckets (to be used when implementing storage features)
  // static const String bookCoversBucket = 'book-covers';
  // static const String profilePicturesBucket = 'profile-pictures';
}
