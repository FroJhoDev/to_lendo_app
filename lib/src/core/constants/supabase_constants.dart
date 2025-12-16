/// {@template supabase_constants}
/// Constants for Supabase configuration.
/// {@endtemplate}
sealed class SupabaseConstants {
  SupabaseConstants._();

  /// Supabase project URL
  ///
  static const String supabaseUrl = 'https://bcklihlqpjtjvjzoxeud.supabase.co';

  /// Supabase anonymous/public key
  ///
  static const String supabaseAnonKey =
      'sb_secret_z6SamHhPJBhojMWQ39PwvA_9iaz903u';

  // Tables names (to be used when implementing database features)
  // static const String booksTable = 'books';
  // static const String readingSessionsTable = 'reading_sessions';
  // static const String usersTable = 'users';

  // Storage buckets (to be used when implementing storage features)
  // static const String bookCoversBucket = 'book-covers';
  // static const String profilePicturesBucket = 'profile-pictures';
}
