/// App Animatinons Class
class AppAnimations {
  /// Base Animations Path
  static const String _baseUrl = 'assets/animations';

  /// List to All Animations
  static List<String> get animationsList => [loadingAnimation, bookLoaderAnimation];

  /// Baby loading animation
  static String get loadingAnimation => '$_baseUrl/loading.json';

  /// Book Loader Animation
  static String get bookLoaderAnimation => '$_baseUrl/book_loader.json';
}
