/// App Images Class
class AppImages {
  /// Base Images Path
  static const String _baseUrl = 'assets/images';

  /// List to All Images
  static List<String> get imagesList => [appLogo, appIcon];

  /// Logo Image
  static String get appLogo => '$_baseUrl/to_lendo_logo.png';

  /// App Icon Image
  static String get appIcon => '$_baseUrl/to_lendo_icon.png';
}
