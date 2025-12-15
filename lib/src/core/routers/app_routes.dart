/// {@template app_routes}
/// Enum containing all application routes.
/// {@endtemplate}
enum AppRoutes {
  /// Onboarding route
  onboarding('/onboarding'),

  /// Authentication route
  auth('/auth'),

  /// Registration route
  register('/register'),

  /// Home route
  home('/home'),

  /// Add book route
  addBook('/add-book'),

  /// Book details route with ID parameter
  bookDetails('/book/:id'),

  /// Profile route
  profile('/profile'),

  /// Statistics route
  statistics('/statistics');

  /// {@macro app_routes}
  const AppRoutes(this.path);

  /// Route path
  final String path;
}
